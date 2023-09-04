use sakila;

select * from actor;

-- Task 1 display first_name,last_name,actor_id,last_update form actor table
select actor_id,first_name,last_name,last_update from actor;

-- Task 2 -a. display full name of all actor
select concat(first_name,' ',last_name) as Full_name from actor;

-- b. display first_name of actors along with the count of repeated first name
select first_name,count(first_name) as count_of_first_name from actor group by first_name HAVING COUNT(first_name) > 1;

-- c. display last_name of actors along with the count of repeated last name
select last_name,count(last_name) as count_of_last_name from actor group by last_name HAVING COUNT(last_name) > 1;

-- Task 3 -display the count of movies grouped by rating.
select * from film;
select rating,count(title) as Movie_count from film group by rating;

-- task 4- display average rental rates based on the movie rating
select rating,avg(rental_rate) as average_rental_rate from film group by rating;

-- task 5- a. display the movie titles where the replacement cost is up to $9
select title,replacement_cost from film where replacement_cost <= 9;

-- b. display the movie titles where the replacement cost is between $15 and $20
select title,replacement_cost from film where replacement_cost between 15 and 20;

-- c. display the movie titles with the highest replacement cost and the lowest rental cost
select max(replacement_cost) as highest_replacement_cost,min(replacement_cost) as lowest_replacement_cost from film;

-- Task 6- list all the movies along with the number of actors listed for each movie 
select * from film;
select * from film_actor;
select * from actor;

select f.title,count(fa.actor_id) as number_of_actor from film f join film_actor fa on f.film_id=fa.film_id 
										 join actor a on fa.actor_id=a.actor_id group by f.title;
                                         
-- Task 7 - display the movie title starting with the letters 'K' and 'Q' 
select * from film where title like 'K%' or 'Q%';
                                         
-- Task 8 - display firstname, lastname of all actor who are a part of 'agent truman' movie
select * from film;
select * from film_actor where film_id=6;
select * from actor where actor_id in(21,23,62,108,137,169,197);

select a.actor_id,a.first_name,a.last_name from film f join film_actor fa on f.film_id=fa.film_id join actor a on a.actor_id=fa.actor_id
																where f.title='agent truman';
                                                                
-- Task 9 identify and display the names of the movies in the family category
select * from film;
select * from film_category;
select * from category;

select f.title,c.name from film f join film_category fc on f.film_id=fc.film_id join category c on fc.category_id=c.category_id
									where c.name='Family';
                                    
-- Task 10 - display the names of the most frequently rented movies in descending order, so that the management can maintain more copies of such movies.
select * from film;
select * from inventory;

select f.title,count(i.inventory_id) as most_frequently_rented_movie from film f join inventory i on f.film_id=i.film_id
															group by f.title order by most_frequently_rented_movie desc;
                                                            
-- Task 11 - calculate and display the number of movie categories where the average between the movie replacement
--  cost and the rental rate is greater than $15
select * from film;
desc film;
select * from film_category;
desc film_category;
select * from category;
desc category;

SELECT c.name,COUNT(*) AS category_count
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c ON c.category_id = fc.category_id
WHERE (f.replacement_cost + f.rental_rate) / 2 > 15 group by c.name;                                                                            

-- Task 12 - display the names of these categories/genres and the number of movies per category/genre sort by the number of movies
select * from film;
select * from category;
select count(*) from film_category where category_id =1;

select c.name,count(f.title) as number_of_movie from film f join film_category fc on f.film_id=fc.film_id join category c on fc.category_id=c.category_id
group by c.name order by number_of_movie desc;