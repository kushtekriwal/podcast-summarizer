# **Podcast Summarizer Service**

## Description

Service for the purpose of summarizing Youtube podcasts.

## Quickstart

**Conda** and **Poetry** are used to manage the Python environment and dependencies for 
working on this production services. A single python environment is defined each of the
services (`environment.yaml` and `pyproject.toml`). Code quality checks are run on 
commit/push using **pre-commit** (`pre-commit-config.yaml`). These checks as well 
will run any **pytest** tests using **github actions** when a PR is created 
(`code-quality.yaml`).

### Setting Up to work on the service

1. Clone the repo: `git clone https://github.com/kushtekriwal/podcast-summarizer.git`
2. Navigate to the root folder of the repo: e.g. `cd "podcast-summarizer`
3. Setup the python environment for the service: `conda env create -f environment.yaml`
4. Activate the python environment for the service: eg `conda activate podcast.summarizer`
5. Setup poetry: `poetry install`
6. Install pre-commit: `pre-commit install -t pre-push`
7. Setup your working branch: `git checkout -b *name_of_branch*`
8. Do your work.
9. Stage your changes: `git add -A`
10. Run code quality (pre-commit) check: `pre-commit`
11. Commit your changes: `git - commit -m "Commit comment"`
12. Push your changes: `git push origin *name_of_branch*`
13. Create your PR on github.com

### Deploying the Service image to an AWS ECR

1. After your PR has been approved and merged into main, tag the main branch using semantic version (i.e. 1.1.1)

    `git tag v1.1.1`
    
    `git push --tags`
2. Go to the main page of the repo on github (https://github.com/AquaticInformatics/analytics.anomaly.flatline), and click on *Create Release*. Choose the tag you created previously and click Release.
3. Monitor the github action to confirm that the image is successfully built and deployed to the appropriate AWS ECR.
4. Follow the procedure on our confluence page, https://aquaticinformatics.atlassian.net/l/cp/PaFxx5gW , to test the new service in the deveopment environment on AWS Lambda.

### Running Code Quality Checks

To manually run the code quality checks run `pre-commit` or `pre-commit --all-files`. To manually run tests run `pytest`
in an experiment or root project directory

### Adding Packages

If you need to use a package not already included in the project use `poetry add name_of_package`
