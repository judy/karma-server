Feature: Users via JSON
  In order to manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.
  
  Scenario: Create a user
    When I PUT "/users/bob.json" with body ""
    Then I should get a 201 Created response

  Scenario: Recreate a user
    Given a user "bob"
    When I PUT "/users/bob.json" with body ""
    Then I should get a 200 OK response

  Scenario: Read a user
    Given the following users:
      | id | permalink | created_at          | updated_at          |
      | 1  | bob       | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | harry     | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
    When I GET "/users/bob.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: {
          id: 1,
          permalink: bob,
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-10-01T12:00:00Z"
        }
      }
    """
    
  Scenario: Get a non-existent user
    Given a user "bob"
    When I GET "/users/not-there.json"
    Then I should get a 404 Not Found response
    
  Scenario: Get a user's karma
    Given a user "bob"
    And a bucket "plants"
    And a bucket "animals"
    When I GET "/users/bob/karma.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: bob,
        user_path: /users/bob.json,
        total: 0,
        buckets: {
          plants: {
            total: 0,
            bucket_path: /buckets/plants.json,
            adjustments_path: /users/bob/buckets/plants/adjustments.json
          },
          animals: {
            total: 0,
            bucket_path: /buckets/animals.json,
            adjustments_path: /users/bob/buckets/animals/adjustments.json
          }
        }
      }
    """