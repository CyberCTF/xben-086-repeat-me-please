# Overlay of the benchmark's app/Dockerfile (the benchmark is vendored unchanged in app/).
# What differs from upstream:
# - the COPY sources point into app/app/ (this folder is the build context);
# - the FLAG build argument defaults to this lab's fixed flag, the value upstream's Makefile passes (FLAG{sha256 of the benchmark id}), since the spec passes no build arguments.
# Everything else is upstream's, line for line.

FROM ruby:3.1.2

WORKDIR /app

COPY app/app/Gemfile app/app/Gemfile.lock ./
RUN bundle install

COPY app/app/ .

ARG FLAG=FLAG{129553c73fc5601ea301c317809967bd8b922a69a8a528343d396ed6c13858e9}
ENV FLAG=${FLAG}

RUN echo $FLAG > /app/flag.txt

EXPOSE 4567
CMD ["ruby", "app.rb"]
