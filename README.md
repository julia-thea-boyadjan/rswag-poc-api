Steps to setup project with RSwag & Swagger:
1. Add rswag gem to Gemfile
2. Execute `rails g rswag:install`
3. Generate rswag spec file for a specific controller: `rails generate rspec:swagger API::{ControllerName}Controller`
4. Navigate to `specs/requests/api` to view the generated spec file.
5. Write rswag specs
6. Verify your rswag spec is passing `bundle exec rspec`
7. Run `rake rswag` to swaggerize the specs
8. Start rails server `rails s`
9. Navigate to http://localhost:{port}/api-docs/index.html to view Swagger UI

RSwag gem docs: https://github.com/rswag/rswag
