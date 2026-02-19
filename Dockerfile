FROM python:3.11-slim

# install SWI-Prolog
RUN apt-get update && apt-get install -y swi-prolog

# set working directory
WORKDIR /app

# copy project files
COPY . .

# install python packages
RUN pip install --no-cache-dir -r requirements.txt

# expose port
EXPOSE 10000

# start app
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
