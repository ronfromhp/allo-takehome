# Project Setup

## Prerequisites

Make sure you have the following installed on your machine:
- Node.js (>= 14.x)
- npm (>= 6.x)
- Docker (for running the database)

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/ronfromhp/allo-takehome.git
    cd allo-takehome/app
    ```

2. Install the dependencies:
    ```bash
    npm install
    ```

3. Set up the environment variables:
    - Create a `.env` file in the root directory of the project.
    - Add the following environment variables to the `.env` file:
        ```env
        DATABASE_URL=postgresql://postgres:123@localhost:5432/allo?schema=public
        ```

## Running the Project

### Start the Database

1. Start the database using Docker:
    ```bash
    npm run db:dev:restart
    ```

### Run the Application

1. Start the application in development mode:
    ```bash
    npm run start:dev
    ```
