# gcloud run deploy NAME \   # the Cloud Run service name
#   --source=PATH \          # can use $PWD or . for current dir
#   --project=PROJECT \      # the Google Cloud project ID
#   --region=REGION  \       # ex: us-central1
#   --platform=managed \     # for Cloud Run
#   --allow-unauthenticated  # for public access

# ex: gcloud run deploy my-service --source=. --project=my-project --region=us-central1 --platform=managed --allow-unauthenticated
gcloud run deploy rexios-dev-nginx --source=. --project=rexios-dev-website --region=us-central1 --platform=managed --allow-unauthenticated