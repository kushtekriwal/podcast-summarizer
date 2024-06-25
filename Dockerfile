FROM public.ecr.aws/lambda/python:3.8 AS builder
WORKDIR ${LAMBDA_TASK_ROOT}
ARG PREDICTIVE_ANALYTICS_AUTOMATION_TOKEN

ENV POETRY_HOME="/opt/poetry" \
    POETRY_NO_INTERACTION=1 \
    POETRY_VERSION="1.5.1"

# install poetry and configure
RUN curl -sSL https://install.python-poetry.org | python3 - --version ${POETRY_VERSION}
ENV PATH="$POETRY_HOME/bin:$PATH"

# copy poetry configuration files
COPY poetry.lock pyproject.toml ./
# use poetry to create a pip compatible requirements.txt
RUN poetry export -f requirements.txt --without-hashes > ${LAMBDA_TASK_ROOT}/requirements.txt

# Install git and configure
RUN yum install -y git-all
RUN git config --global url."https://${PREDICTIVE_ANALYTICS_AUTOMATION_TOKEN}@github.com".insteadOf https://github.com

# Install dependencies using pip
RUN pip3 install --no-cache -r ${LAMBDA_TASK_ROOT}/requirements.txt

FROM public.ecr.aws/lambda/python:3.8

# Packages installed by pip will be located in /var/lang/lib/python3.8/site-packages folder
# TODO would be better to dynamically determine site-packages directory
COPY --from=builder /var/lang/lib/python3.8/site-packages /var/lang/lib/python3.8/site-packages

# copy application last to leverage Docker cache
WORKDIR ${LAMBDA_TASK_ROOT}
COPY ./flatline_v1 ./flatline_v1

ENV MODULE_NAME flatline_v1.src.service.main

CMD ["flatline_v1.src.service.main.handler"]

## How to build and push the container manually
## from the root repo directory execute:
## docker build --build-arg PREDICTIVE_ANALYTICS_AUTOMATION_TOKEN=$PREDICTIVE_ANALYTICS_AUTOMATION_TOKEN --tag 719414707371.dkr.ecr.us-west-1.amazonaws.com/ds-service/anomaly_flatline_v1 .
## docker push 719414707371.dkr.ecr.us-west-1.amazonaws.com/ds-service/anomaly_flatline_v1
