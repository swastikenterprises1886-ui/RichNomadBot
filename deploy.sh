#!/bin/bash

# Exit on error
set -e

# Variables
PROJECT_ID="your-gcp-project-id"
REGION="your-gcp-region"
SERVICE_NAME="your-cloud-run-service-name"
DOCKER_IMAGE_NAME="gcr.io/$PROJECT_ID/$SERVICE_NAME"
TELEGRAM_TOKEN="your-telegram-bot-token"
WEBHOOK_URL="https://your-cloud-run-url"

# Step 1: Set up GCP Project
gcloud projects create $PROJECT_ID --set-as-default
gcloud config set project $PROJECT_ID

# Step 2: Create secrets
echo -n $TELEGRAM_TOKEN | gcloud secrets create TELEGRAM_TOKEN --data-file=-
gcloud secrets create YOUR_SECRET_NAME --data-file=your-secret-file

# Step 3: Build Docker image
gcloud builds submit --tag $DOCKER_IMAGE_NAME .

# Step 4: Deploy to Cloud Run
gcloud run deploy $SERVICE_NAME \
  --image $DOCKER_IMAGE_NAME \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated

# Step 5: Configure Telegram webhook
curl -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/setWebhook?url=$WEBHOOK_URL"

echo "Deployment complete!"