FROM python:3.11


# Set the working directory
WORKDIR /app

# Install system dependencies required for Spacy
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy only relevant files into the container
COPY App.py Courses.py requirements.txt README.md /app/
COPY Logo /app/Logo
COPY Uploaded_Resumes /app/Uploaded_Resumes

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Download Spacy model
RUN python -m spacy download en_core_web_sm

# Expose the Streamlit default port
EXPOSE 8501

# Set environment variables (Replace with actual values or use Docker secrets for security)
ENV GEMINI_API_KEY=AIzaSyAovyixGE4tBbvr2_raLWE6bcyplFC3IHM

# Command to run the Streamlit app
CMD ["streamlit", "run", "App.py", "--server.port=8501", "--server.address=0.0.0.0"]
