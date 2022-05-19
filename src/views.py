from xml.sax.handler import property_interning_dict
from authentication import token_auth, env
from models import User, Read, Category, BookToCategory
from werkzeug.security import generate_password_hash, check_password_hash
from flask import request,  jsonify, request, make_response
import jwt
from app import app, db
import datetime
from insert_data_to_db import insert_data_into_db, Books


@app.route('/api/sign_up', methods=['POST'])
def sign_up():
    """Sign up route

    Args:
        content (json): email, first_name, password1, password2

    Returns:
        json: message if user register successfully
    """
    try:
        if request.method == "POST":
            content = request.get_json()
            email = content['email']
            first_name = content['first_name']
            password1 = content['password1']
            password2 = content['password2']

            # user = User.query
            user = User.query.filter_by(email=email).first()

            if user:
                return jsonify({'message': 'Account already exists.'})
            elif len(email) < 4:
                return jsonify({'message': 'Email must be greater than 3 characters.'})
            elif len(first_name) < 2:
                return jsonify({'message': 'First name must be greater than 1 character.'})
            elif password1 != password2:
                return jsonify({'message': 'Passwords don\'t match.'})
            elif len(password1) < 7:
                return jsonify({'message': 'Password must be at least 7 characters.'})
            else:
                user = User.query.filter_by(first_name=first_name).first()
                if user:
                    return jsonify({'message': 'This name already taken'})

            new_user = User(
                first_name=first_name, email=email, password=generate_password_hash(password1, method='sha256'))
            db.session.add(new_user)
            db.session.commit()
            return jsonify({'message': 'Registration successfully completed!'})
    except Exception as ex:
        return jsonify({"message": str(ex)})


@app.route('/api/login', methods=['POST'])
def login():
    """Login route

    Returns:
        token or error message if failed
    """
    try:
        if request.method == "POST":
            auth = request.authorization

            if not auth or not auth.username or not auth.password:
                return make_response('Authentication Failed.', 401, {'WWW-Authenticate': 'Basic realm="Login required!"'})

            user = User.query.filter_by(first_name=auth.username).first()

            if user:
                if check_password_hash(user.password, auth.password):
                    token = jwt.encode({'id': user.id, 'exp': datetime.datetime.utcnow(
                    ) + datetime.timedelta(minutes=30)}, env.str('SECRET_KEY'))

                    return jsonify({'token': token.decode('UTF-8')})
                return make_response('Authentication Failed.', 401, {'WWW-Authenticate': 'Basic realm="Incorrect password, try again.'})
            return make_response('Authentication Failed.', 401, {'WWW-Authenticate': 'User does not exist.'})
    except Exception as ex:
        return jsonify({"message": str(ex)})

@app.before_request
def init_db(): 
    insert_data_into_db()

@app.route('/api/books', methods=['GET','POST'])
def available_books():
    """This function is accessible to non-members.

    Args for criteria:
        json: keys(categories, book_rating, author), values(Adventure, 8.5, Leonardo DiCaprio)

    Returns:
        json: returns all available books with and without criteria
    """
    try:
        book_dict = {"title": Books.title,"book_rating": Books.book_rating, "author":  Books.author}

        book_to_category_dict = {"categories": BookToCategory.category}


        book = Books.query.all()

        if request.method == 'POST':
            content = request.get_json()
            criteria_book = []
            criteria_category = []
            for i, (key, value) in enumerate(content.items()):
                if key in book_dict:
                    if isinstance(value, str):
                        if ',' in value:
                            temp_list = value.split(',')
                            for value in temp_list:
                                value = "%{}%".format(value)
                                criteria_book.append(book_dict[key].like(value))
                        else:
                            value = "%{}%".format(value)
                        if key in book_dict:
                            criteria_book.append(book_dict[key].like(value))
                    # if criteria value is integer
                    else:
                        if key in book_dict:
                            criteria_book.append(book_dict[key] >= value)
                else:
                    if ',' in value:
                        temp_list = value.split(',')
                        for value in temp_list:
                            value = "%{}%".format(value)
                            criteria_category.append(book_to_category_dict[key].like(value))

            category = BookToCategory.query.filter(criteria_category[0]).all()

            for i in range(1, len(criteria_category)):
                query = BookToCategory.query.filter(criteria_category[i]).all()
                category = list(set.union(set(category), set(query)))

            if criteria_book:
                book = Books.query.filter(criteria_book[0]).all()
                for i in range(1, len(criteria_book)):
                    query = Books.query.filter(criteria_book[i]).all()
                    book = list(set.intersection(set(book), set(query)))
            
            i = 0
            while i < len(book):
                categories_for_book = BookToCategory.query.filter(book[i].title == BookToCategory.book_name).all()
                check = all(item in category for item in categories_for_book)
                if not check:
                    book.remove(book[i])
                    i -= 1
                i += 1                    

        if not book:
            return jsonify({"message": "No books found"})
        results = []
        for data in book:
            Dict = dict((column.name, getattr(data, column.name))
                                for column in data.__table__.columns)
            if request.method == 'POST':
                temp_string = ""    
                for j in range(len(category)):
                    if data.title == category[j].book_name:
                        temp_string += category[j].category + ","
                Dict["category"] = temp_string[0:-1]
            results.append(Dict)

        return jsonify(results)
    except Exception as ex:
        return jsonify({"message": str(ex)})

@app.route('/api/books/<book_title>', methods=['GET'])
def get_details(book_title):
    """ This function is accessible to non-members.
    Args:
        book_title (str): The book that the user desires to get more information

    Returns:
        json: Details about a specific book based on book_title
    """
    try:
        book_title = "%{}%".format(book_title)
        book = Books.query.filter(Books.title.like(book_title)).all()
        if not book:
            return jsonify({"message": "This book does not exist"})
        results = []
        category = BookToCategory.query.filter(book[0].title == BookToCategory.book_name).all()

        for i in range(1, len(book)):
            query = BookToCategory.query.filter(book[i].title == BookToCategory.book_name).all()
            category = list(set.union(set(category), set(query)))

        for data in book:
            Dict = dict((column.name, getattr(data, column.name))
                                for column in data.__table__.columns)
            temp_string = ""    
            for j in range(len(category)):
                if data.title == category[j].book_name:
                    temp_string += category[j].category + ","
            Dict["category"] = temp_string[0:-1]
            results.append(Dict)

        return jsonify(results)
    except Exception as ex:
        return jsonify({"message": str(ex)})


@app.route('/api/books/user/rented-books', methods=['GET'])
@ token_auth
def get_rented_books(current_user):
    """ Rented Bookss route (This function is accessible to members only.)
    Returns:
        json: Rented books of the current_user 
    """
    try:
        user = Read.query.filter_by(user_id=current_user.id).all()
        if not user:
            return jsonify({"message": "You have not rented any books yet."})
        results = []
        for data in user:
            results.append(dict((column.name, getattr(data, column.name))
                                for column in data.__table__.columns))
        return jsonify(results)
    except Exception as ex:
        return jsonify({"message": str(ex)})


@app.route('/api/books/<book_id>/rent', methods=['POST'])
@ token_auth
def rent_book(current_user, book_id):
    """Rent route (This function is accessible to members only.)

    Args:
        current_user (dict): credentials current user
        book_id (str): The book that the user desires to rent

    Returns:
        json: success message if the user has succesfully rented the book or error message if something went wrong
    """
    try:
        if request.method == "POST":
            book = Books.query.filter_by(id=book_id).first()
            if not book:
                return jsonify({"message": "This book id does not exist"})
            read = Read.query.filter_by(
                book_id=book_id, user_id=current_user.id, return_date=None).first()
            if read:
                return jsonify({"message":  "You have already rented this book. Return it in order to be able to rent it again."})
            new_rent = Read(
                book_id=book_id, user_id=current_user.id, rent_date=datetime.date.today(), return_date=None)
            db.session.add(new_rent)
            db.session.commit()
            return jsonify({"message": f"You have successfully rented the book {book.title}.  The final amount will be calculated when you will return it."})
    except Exception as ex:
        return jsonify({"message": str(ex)})


@app.route('/api/books/<book_id>/return', methods=['PATCH'])
@ token_auth
def return_book(current_user, book_id):
    """Return route "Rent route (This function is accessible to members only.)

    Args:
        current_user (dict): credentials current user
        book_id (str): The book that the user wants to return

    Returns:
        json: success message if the user has succesfully returned the book or error message if something went wrong
    """
    try:
        if request.method == "PATCH":
            book = Books.query.filter_by(id=book_id).first()
            if not book:
                return jsonify({"message": "This book id does not exist"})
            read = Read.query.filter_by(
                book_id=book_id, user_id=current_user.id, return_date=None).first()
            if read:
                time = datetime.date.today() - read.rent_date
                total_amount = get_amount(time.days).get_json()
                read.return_date = datetime.date.today()
                db.session.commit()
                return jsonify({"message": f"You have successfully returned the book. The total amount of this rent is {total_amount['Amount']}"})
            return jsonify({"message": "Rent this book in order to return it."})
    except Exception as ex:
        return jsonify({"message": str(ex)})


@app.route('/api/books/amount/<int:days>', methods=['GET'])
def get_amount(days):
    """ Amount route (This function is accessible to non-members.)

    Args:
        days (int): The number of days that the user will rent a book

    Returns:
        json: The Amount that user has to pay based on the number of days
    """
    return jsonify({'Amount': (6 + (days-3)*1 if days > 3 else days*2)})
