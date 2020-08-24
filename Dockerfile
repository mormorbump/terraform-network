FROM python:3.6

SHELL ["/bin/bash", "-c"]
ARG pip_installer="https://bootstrap.pypa.io/get-pip.py"
ARG awscli_version="1.16.168"

RUN pip install awscli==${awscli_version}

RUN pip install --user --upgrade aws-sam-cli
ENV PATH $PATH:/root/.local/bin

RUN apt-get update && \
  apt-get install -y less vim git \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

# ubuntuはbashではなくDashなのでsourceではなく.を使う
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
  export PATH="$HOME/.tfenv/bin:$PATH" && \
  echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile && \
  source ~/.bash_profile

COPY . /root/src

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
COPY .aws /root/.aws
COPY init.sh /root/init.sh
RUN chmod +x /root/init.sh && /root/init.sh

WORKDIR /root/src