from environs import Env
import unittest
import requests

env = Env()
env.read_env()


class Tests(unittest.TestCase):
    api_url = "http://127.0.0.1:5000/api"
    book_object = {"categories": "Adventure,Fantasy", "book_rating": 8}
    test_user = {"email": "kostantinosmavros28newemail@gmail.com", "first_name": "kostas27",
                 "password1": "kostaskostas", "password2": "kostaskostas"}

    def test_sign_up(self):
        sign_up = requests.post(
            Tests.api_url + "/sign_up", json=Tests.test_user)
        self.assertEqual(sign_up.status_code, 200)
        self.assertEqual(sign_up.json(), {
                         'message': 'Registration successfully completed!'})

    def test_available_books(self):
        result = requests.get(Tests.api_url + "/books")
        self.assertEqual(result.status_code, 200)
        self.assertEqual(len(result.json()), 6)  # Six records

    def test_available_books_with_criteria(self):
        result = requests.post(Tests.api_url + "/books",
                              json=Tests.book_object)
        self.assertEqual(result.status_code, 200)
        self.assertEqual(result.json(), [{"author": "John Ronald Reuel Tolkien","book_rating": 8.4,"category": "Fantasy,Adventure","id": 2,"title": "The Lord of the Rings"},
            {"author": "John Ronald Reuel Tolkien","book_rating": 8.0,"category": "Adventure,Fantasy","id": 3,"title": "The Hobbit"}])

    def test_get_book_details(self):
        result = requests.get(
            Tests.api_url + f"/books/Harry Potter and the Philosopher’s Stone")
        self.assertEqual(result.status_code, 200)
        self.assertEqual(result.json(), [{"author": "J.K. Rowling", "book_rating": 8.8,
                         "category": "Action,Fantasy", "id": 1, "title": "Harry Potter and the Philosopher’s Stone"}])

    def test_rent_a_book(self):
        login = requests.post(
            f"http://{env.str('USERNAME')}:{env.str('PASSWORD')}@127.0.0.1:5000/api/login")
        self.assertEqual(login.status_code, 200)
        header = {'x-access-token': login.json()['token']}

        rent = requests.post(
            Tests.api_url + f"/books/{5}/rent", headers=header)
        self.assertEqual(login.status_code, 200)
        self.assertEqual(rent.json(), {
                         "message": "You have successfully rented the book Great Expectations.  The final amount will be calculated when you will return it."})

    def test_return_a_movie(self):
        login = requests.post(
            f"http://{env.str('USERNAME')}:{env.str('PASSWORD')}@127.0.0.1:5000/api/login")
        self.assertEqual(login.status_code, 200)
        header = {'x-access-token': login.json()['token']}

        rent = requests.patch(
            Tests.api_url + f"/books/{5}/return", headers=header)
        self.assertEqual(login.status_code, 200)
        # rent and return same day
        self.assertEqual(rent.json(), {
                         "message": f"You have successfully returned the book. The total amount of this rent is {0}"})

    def test_amount(self):
        result = requests.get(
            Tests.api_url + f"/books/amount/{10}")  # ten days
        self.assertEqual(result.status_code, 200)
        self.assertEqual(result.json(), {"Amount": 13})


if __name__ == '__main__':
    unittest.main()
