import json
from google.cloud import storage

class CloudStorageUtils:
    def __init__(self, bucket_name):
        self.client = storage.Client()
        self.bucket = self.client.bucket(bucket_name)

    def save_json(self, data, destination_blob_name):
        # Convert data to JSON and upload to GCS
        json_data = json.dumps(data)
        blob = self.bucket.blob(destination_blob_name)
        blob.upload_from_string(json_data, content_type='application/json')

    def load_json(self, source_blob_name):
        # Load JSON data from GCS
        blob = self.bucket.blob(source_blob_name)
        json_data = blob.download_as_text()
        return json.loads(json_data)