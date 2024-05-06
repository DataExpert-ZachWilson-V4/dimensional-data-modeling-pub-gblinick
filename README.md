# Dimensional Data Modeling

This assignment involves working with the **`actor_films`** dataset. Your task is to construct a series of SQL queries and table definitions that will allow us to model the **`actor_films`** dataset in a way that facilitates efficient analysis. This involves creating new tables, defining data types, and writing queries to populate these tables with data from the **`actor_films`** dataset.

### Submission Guidelines

1. **Complete assignment prompts:** Write your SQL in the query file corresponding to the prompt number in the `submission` folder. Do not change the file names!

2. **Lint your SQL code for readability.** This ensures your code is easy to follow and understand.

3. **Add comments to your queries.** Use the **`--`** syntax to explain each step and help the reviewer understand your thought process. 

4. **Submit your work:**
   - You can work on multiple branches if it happens that way, but your final submission must be on one branch. 
   - Before opening a PR, check that you've addressed all the questions/prompts in the assignment instructions, review your code for errors, and ensure thorough commenting.
      > Once a PR is opened, a link to that specific PR will be shared with our TA team for review. We are using GitHub classroom to automate and handle several aspects of the review process and cannot accommodate individual requests for changes, so **please proceed with caution**.
      > 
   - Open a PR to submit your assignment.
   - You can revise and push changes to the PR branch before the deadline.
        - Some assignments may include tests or feedback generated by the GitHub Action, which you may use to revise your solutions before the deadline.
   - Only open one PR for your submission. The first PR you open will be considered your final submission. 
        - Therefore, ensure that you have fully completed the assignment before opening the PR, and only push changes to that specific branch/PR if necessary.
   - Avoid further changes after the deadline. They won't be reviewed and committing changes after the deadline can cause confusion and delay the review process.
   - Enhance your review by helping your reviewer. Add comments under 'Files changed' to summarize or highlight key parts of your code.
        - If you've already added comments throughout your code as recommended, simply reiterate or summarize them in this section.

Grading:
   - Grades are pass or fail, used solely for certification.
   - Changes made after the deadline won't be considered. 
   - An approved PR means a Pass grade. If changes are requested, the grade will be marked as Fail.
   - The reviewer may request changes, but they're optional and won't be reviewed.
   - Only one (human) review will be provided for grading.


## Dataset Overview

The `actor_films` dataset contains the following fields:

- `actor`: The name of the actor.
- `actor_id`: A unique identifier for each actor.
- `film`: The name of the film.
- `year`: The year the film was released.
- `votes`: The number of votes the film received.
- `rating`: The rating of the film.
- `film_id`: A unique identifier for each film.

The primary key for this dataset is (`actor_id`, `film_id`).

## Assignment Tasks

### Actors Table DDL (query_1)

Write a DDL query to create an `actors` table with the following fields:

- `actor`: Actor name
- `actor_id`: Actor's ID
- `films`: An array of `struct` with the following fields:
  - `film`: The name of the film.
  - `votes`: The number of votes the film received.
  - `rating`: The rating of the film.
  - `film_id`: A unique identifier for each film.
- `quality_class`: A categorical bucketing of the average rating of the movies for this actor in their most recent year:
  - `star`: Average rating > 8.
  - `good`: Average rating > 7 and ≤ 8.
  - `average`: Average rating > 6 and ≤ 7.
  - `bad`: Average rating ≤ 6.
- `is_active`: A BOOLEAN field that indicates whether an actor is currently active in the film industry (i.e., making films this year).
- `current_year`: The year this row represents for the actor

### Cumulative Table Computation Query (query_2)

Write a query that populates the `actors` table one year at a time.

### Actors History SCD Table DDL (query_3)

Write a DDL statement to create an `actors_history_scd` table that tracks the following fields for each actor in the `actors` table:

- `quality_class`
- `is_active`
- `start_date`
- `end_date`

Note that this table should be appropriately modeled as a Type 2 Slowly Changing Dimension Table (`start_date` and `end_date`).

### Actors History SCD Table Batch Backfill Query (query_4)

Write a "backfill" query that can populate the entire `actors_history_scd` table in a single query.

### Actors History SCD Table Incremental Backfill Query (query_5)

Write an "incremental" query that can populate a single year's worth of the `actors_history_scd` table by combining the previous year's SCD data with the new incoming data from the `actors` table for this year.