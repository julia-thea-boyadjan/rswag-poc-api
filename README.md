Steps to setup project with RSwag & Swagger:
1. Add rswag gem to Gemfile
2. Execute `rails g rswag:install`
3. Generate the shell for the rswag controller spec: 
4. Generate rswag spec file for a specific controller: `rails generate rspec:swagger API::{ControllerName}Controller`
5. Navigate to specs/requests/api to view the generated spec file.
6. Write rswag specs
7. Verify your rswag spec is passing `bundle exec rspec`
8. Run `rake rswag` to swaggerize the specs
9. Start rails server `rails s`
10. Navigate to http://localhost:3000/api-docs/index.html to view Swagger UI

