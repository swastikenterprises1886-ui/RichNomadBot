# Deployment Guide for RichNomadBot

This document outlines the steps required to deploy the RichNomadBot on Google Cloud Platform (GCP).

## Prerequisites
- A Google Cloud Platform account.
- Google Cloud SDK installed on your local machine.
- Docker installed on your local machine.

## GCP Setup Steps
1. **Create a New Project**
   - Go to the GCP Console: [Google Cloud Console](https://console.cloud.google.com/).
   - Click on the project drop-down and select "New Project."
   - Name your project and note the project ID.

2. **Enable the Cloud Run API**
   - In the GCP Console, navigate to `APIs & Services` > `Library`.
   - Search for `Cloud Run API` and click on `Enable`.

3. **Configure Billing** (if not already configured)
   - Go to `Billing` in the GCP Console and set up a billing account.

## Creating Secrets
1. **Navigate to Secret Manager**
   - In the GCP Console, go to `Security` > `Secret Manager`.

2. **Create a New Secret**
   - Click on `Create Secret`.
   - Enter a name and value for your secret (e.g., Telegram Bot Token).
   - Click `Save`.

## Building Docker Image
1. **Create a Dockerfile**
   If not already existing, create a `Dockerfile` in your project directory:
   ```Dockerfile
   # Sample Dockerfile for RichNomadBot
   FROM python:3.8-slim
   WORKDIR /app
   COPY . .
   RUN pip install -r requirements.txt
   CMD ["python", "app.py"]
   ```

2. **Build the Docker Image**
   Run the following command in your terminal:
   ```bash
   docker build -t richnomadbot .
   ```

## Deploying to Cloud Run
1. **Deploy the Docker Image**
   In your terminal, run:
   ```bash
   gcloud run deploy richnomadbot \
       --image gcr.io/YOUR_PROJECT_ID/richnomadbot \
       --platform managed \
       --region us-central1 \
       --allow-unauthenticated
   ```
   Replace `YOUR_PROJECT_ID` with your actual project ID.

## Configuring Telegram Webhook
1. **Set Up Webhook**
   Use the following URL format to set your webhook:
   ```bash
   https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook?url=<CLOUD_RUN_URL>
   ```
   Replace `<YOUR_BOT_TOKEN>` and `<CLOUD_RUN_URL>` with appropriate values.

## Troubleshooting Tips
- **Deployment Issues**: Check logs in the Cloud Run console for error messages.
- **Secret Access**: Ensure the Cloud Run service account has access to the secrets you created.
- **Webhook Issues**: Verify that the Cloud Run service URL is publicly accessible.

For more detailed troubleshooting steps, refer to the GCP documentation or the Telegram Bot API documentation.