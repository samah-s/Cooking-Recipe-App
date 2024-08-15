# cooking_recipe_app

A Flutter application that allows users to input URLs for cooking recipes, whether from a website or YouTube, and generates a list of ingredients and a step-by-step checklist for the recipe. The app simplifies the cooking process by extracting and organizing recipe information.

## Getting Started

This project is a starting point for a Flutter application.

### Features

- **Recipe Extraction**: Extract recipes from URLs provided by the user.
- **Ingredient List**: Automatically generate a list of ingredients from the recipe.
- **Step-by-Step Checklist**: Create a checklist of cooking steps to follow.
- **Support for Websites and YouTube**: Handle both recipe articles and YouTube videos.
- **User-Friendly Interface**: Simple and intuitive design for ease of use.

### LLM Integration
This project utilizes a large language model (LLM) deployed as part of the backend to process and analyze recipe data. The LLM is used for extracting and organizing recipe information into a structured format.

#### Deployment
The LLM is deployed via a Flask backend, which handles requests from the Flutter app. The backend API endpoints are integrated with the Flutter app to fetch and process data. Ensure the Flask server is running and accessible for the Flutter app to interact with the LLM.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/samah-s/Cooking-Recipe-App.git
   cd Cooking-Recipe-App
2. **Install Dependencies**:
   ```bash
   Ensure you have Flutter installed. Then run
   flutter pub get
4. **Run the Application**:
   ```bash
   flutter run

### Dependencies
Here are the dependencies used in this project:

- flutter: The Flutter framework itself.
- http: For making HTTP requests.
- web_scraper: For web scraping.
- provider: For state management.

For a complete list of dependencies and their versions, refer to the pubspec.yaml file in the project.
