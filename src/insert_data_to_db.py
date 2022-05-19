from models import Books, BookToCategory
from app import db

Books_db = (
    (1, 'Harry Potter and the Philosopher’s Stone', 'Action,Fantasy',
     '8.8', 'J.K. Rowling'),
    (2, 'The Lord of the Rings', 'Adventure,Fantasy',
     '8.4', 'John Ronald Reuel Tolkien'),
    (3, 'The Hobbit', 'Adventure,Fantasy', '8', 'John Ronald Reuel Tolkien'),
    (4, 'A Tale of Two Cities','Historical novel', '7.8', 'Charles Dickens'),
    (5, 'Great Expectations', 'Novel,Bildungsroman','7.5', 'Charles Dickens'),
    (6, 'The Stories of Anton Chekhov', 'Novel,Classic Literature','8', 'Anton Chekhov')
)


def insert_data_into_db():
    """Inserts data into database if database is empty

    Args:
        conn (postegres cursor)
        query (str): current query to be executed

    Returns:
        row(list): The data from the query
    """
    book = Books.query.all()

    if not book:
        for data in Books_db:
            book = Books(id=data[0], title=data[1], book_rating=data[3], author=data[4])
            db.session.add(book)
            db.session.commit()

        for data in Books_db:
            categories = data[2].split(',')
            for category in categories:
                book_to_category = BookToCategory(book_name=data[1],category=category)
                db.session.add(book_to_category)
                db.session.commit()
    return 0





