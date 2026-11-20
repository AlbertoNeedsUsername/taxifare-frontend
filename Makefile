include .env

.PHONY: run-streamlit

GCP_IMAGE = $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(GCP_REPOSITORY)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

run-streamlit:
	uv run streamlit run app.py

docker-run-local:
	docker run -it -p 8501:8501 --expose 8080 ${DOCKER_IMAGE_NAME}:dev

docker-build-local:
	docker build -t ${DOCKER_IMAGE_NAME}:dev .

docker-build-cloud:
	docker buildx build --platform linux/amd64 -t $(GCP_IMAGE) --load .

docker-push:
	docker push $(GCP_IMAGE)

docker-deploy:
	gcloud run deploy $(GCP_SERVICE) \
		--image $(GCP_IMAGE) \
		--region $(GCP_REGION) \
		--project $(GCP_PROJECT_ID) \
		--port 8080 \
		--allow-unauthenticated
