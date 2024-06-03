FROM debian:latest
WORKDIR /app

RUN apt update && apt upgrade -y && apt install git jq curl
RUN REPO="invoke-ai/InvokeAI"
RUN LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest | jq -r '.tarball_url')
RUN curl -L $LATEST_RELEASE_URL -o latest-release.tar.gz
RUN tar -xzvf latest-release.tar.gz
RUN EXTRATED_DIR=$(tar -tzf latest-release.tar.gz | head -1 | cut -f1 -d"/")
RUN cd $EXTRACTED_DIR
RUN ./webui.sh
