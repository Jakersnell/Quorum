<h2 align="center">
    <a href="#" target="blank_">
        <img height="100" alt="Quorum Logo" src=
        "https://github.com/Deonnaa/MidtermProject/blob/main/Quorum/src/main/webapp/img/quorum.png"/>
    </a>
    <br>
    Quorum: Explore. Connect. Grow.
</h2>

<div align="center">
    
![Static Badge](https://img.shields.io/badge/Quorum-AWS-yellow?link=http%3A%2F%2F52.86.229.80%3A8080%2FQuorum%2Flogin.do)
![Static Badge](https://img.shields.io/badge/Deonna-Repo_Owner-green?link=https%3A%2F%2Fgithub.com%2FDeonnaa)
![Static Badge](https://img.shields.io/badge/Jake-DBA-blue?link=https%3A%2F%2Fgithub.com%2FJakersnell)
![Static Badge](https://img.shields.io/badge/Parris-SCRUM-orange?link=https%3A%2F%2Fgithub.com%2FParrisu)

</div>

## Quorum

### View the website [here!](http://198.58.124.18:8080/Quorum)

#### Mid-term Team Project undertaken as members of Skill Distillery

### Overview
Quorum is a social media platform designed for students. Its goal is to connect students attending the same school.

### Description
Quorum has multiple avenues of social interaction, involving `posts` and `private messages`. After creating an account and selecting the school you attend, you will be given a surplus of actions.
<br><br>
As a user, you can:
* `Update` or `Delete` your profile <br>
* `Search` any content within your school <br>
  * including professors, students, and groups
* Join social groups started by other students
* `Create` posts to those groups or start your own
* Follow and Unfollow other students as well as Removing Followers from your page.
* Enroll or Remove active classes from your schedule
  * _this is purely a social action, to show friends your schedule_
* Send or Recieve `Messages` to and from other users at your school
* Leave a review for current instructors at your school

### Implementation

#### Database
The database schema is centered around the user, everything is related to the user, and the process of designing the database was focused on supporting the experience of the user on the site. This involves a lot of different types of patterns, and our goal was to normalize these as much as possible to provide a cohesive usage of the entities throughout the backend. 

![image](https://github.com/Deonnaa/MidtermProject/blob/main/photos/EntityRelationshipDiagram.png)


### Technologies and Methodologies Used
<br>

Languages: Java <br>
Web: HTML, CSS, Bootstrap 5.3 <br>
Database: SQL, Spring Data, JPA, JDBC, JPQL, Hibernate <br>
Methodologies: TDD, Agile, Scrum  <br>
Backend: Spring, Spring Boot <br>
Configuration Management: Git <br>
IDE: STS4, Eclipse, VSCode <br>

### Lessons Learned
When databases grow into multi-keyed monsters, the mapping requirements for what seems like simple actions can become quite difficult. This is why we made key choices to structure our entities in the most supportive way possible, carefully crafting our relationship representations in both the database schema, aswell as the entity mapping within Java. This involved a lot of careful consideration about fetch types and ownership amongst other aspects. One of the most important tools that we leveraged during this project was communication, serving as the platform for every aspect of our project, we understood that by facilitating proper communication, we could design and build with great efficiency. Along with this, we gained a huge benefit to our skills of technical planning, by focusing on this aspect with highest priority, we achieved a more cohesive structure, enhancing user experience.


### Stretch Goals
1. Enrolling students in courses.
2. Separating students by school ( limits their interaction )
3. Allowing the students to `Rate` professors in their school.


### How to Download and Run

To set up this project to run on your own computer follow the steps below.

 1. Download the project at the top of this project.
 2. Import the project.
        * Open your preferred IDE, and open an existing or new workspace.
        * Right click inside of your project explorer, click import, then `existing project into workspace`.
 3. Install the DB.
        * Open terminal.
        * Navigate to your workspace that contains the db folder. 
            ex.
            
            ```
            cd ~/SD41/Java/MidtermProject/DB
            ```
    
     * Once here, run the command

            ```
            mysql -u root -p < quorumdb.sql

            root
            ```
       
5. Make sure MAMP is running on port 8085, and launch from the Spring `Boot Dashboard`.
        * Click on the globe after it's up and check out the site!

Otherwise just head to the deployed website above.

Thanks for visiting!
    - Quorum team

