# coding: utf-8
from app import db

class Books(db.Model):
    __tablename__ = 'Books'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), nullable=False, unique=True)
    book_rating = db.Column(db.Float)
    author = db.Column(db.String(50))

class User(db.Model):
    __tablename__ = 'User'

    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False, unique=True)
    email = db.Column(db.String(200), nullable=False, unique=True)
    password = db.Column(db.String(600), nullable=False)


class Read(db.Model):
    __tablename__ = 'Read'

    id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.ForeignKey('Books.id'), nullable=False)
    user_id = db.Column(db.ForeignKey('User.id'), nullable=False)
    rent_date = db.Column(db.Date, nullable=False)
    return_date = db.Column(db.Date)

    book = db.relationship('Books')
    user = db.relationship('User')


class BookToCategory(db.Model):
    __tablename__ = 'Book_To_Category'

    id = db.Column(db.Integer, primary_key=True)
    book_name = db.Column(db.ForeignKey('Books.title'), nullable=False)
    category = db.Column(db.ForeignKey('Category.name'), nullable=False)

    Book = db.relationship('Books')
    Category = db.relationship('Category')

class Category(db.Model):
    __tablename__ = 'Category'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)


