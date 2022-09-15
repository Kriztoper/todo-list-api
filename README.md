# TODO List API

This is a simple TODO list API wherein the idea for the API will be used to support the drage and drop feature of of a 
TODO list application

* **Ruby version**: ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin19]


* **Rails version**: Rails 6.1.7


* **Bundler version**: 2.2.25


* **To install gem dependencies on local** (run the following command) (Note: The dependency management tool we are 
using for this project is **Bundler**): `bundle install`


* **Database**: sqlite3 v1.5.0


* **Database creation and initialization** (run the following command): `rails db:create db:migrate db:seed`


* **Run Puma server on local** (run the following command): `rails s`


* **Puma server version**: 5.6.5 (ruby 2.6.3-p62) ("Birdie's Version")


* **To run the test** (run the following command): `rails test`

# Testing the API w/ respect to reqs

Note: Run the specified command on a terminal to check, also make sure that you have `curl` installed locally, if not 
just test the API on alternative local API platforms

1. The user should be able to list all tasks in the TODO list

command: `curl -v http://0.0.0.0:3000/api/v1/tasks  | python -mjson.tool`

2. The user should be able to add a task to the TODO list

command (_Note: replace content and order_number with the values you want to input_): 
`curl -d 'content=Walk the dog&order_number=6' http://0.0.0.0:3000/api/v1/tasks`

3. The user should be able to update the details of a task in the TODO list

command (_Note: replace id, content and order_number with the values you want to input_): 
`curl -X PUT -d content='Walk the very large dog' -d order_number=6 http://0.0.0.0:3000/api/v1/tasks/6`

4. The user should be able to remove a task from the TODO list

command (_Note: replace id, with the value you want to delete_): `curl -X DELETE http://0.0.0.0:3000/api/v1/tasks/6`

5. The user should be able to reorder the tasks in the TODO list, 
A task in the TODO list should be able to handle being moved more than 50 times,
A task in the TODO list should be able to handle being moved to more than one task
away from its current position

command (_Note: uri format is `/tasks/reorder/:this_id/to/:target_order_number` replace :this_id, 
and :target_order_number with the values you want to input_): `curl -d '' http://0.0.0.0:3000/api/v1/tasks/reorder/3/to/2`