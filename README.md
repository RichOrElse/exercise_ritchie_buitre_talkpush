# Exercise Ritchie Buitre

Ruby on Rails exercise for Talkpush.
It checks the GoogleSheet for new candidates with a push of a button.
And then makes API calls to the Talkpush candidate function for each new row detected since last update.

## Prerequisites

* Ruby 2.6.3
* Rails 6.0.3.4
* SQLite
* Yarn

## Development Setup

On your commandline run the following:

Install Ruby gems:

    $ bundle install

Install Yarn packages:

    $ yarn install

Setup the database:

    $ rails db:migrate db:seed

Run the test:

    $ rspec --format doc

Run the server:

    $ rails server -p 3000

Then open on your browser [http://localhost:3000](http://localhost:3000)

### API keys

On your console run this command to open encrypted credentials with an editor:

	EDITOR="vim --wait" bin/rails credentials:edit

Within your editor replace the API keys:

	talkpush:
	  api_key: TALKPUSH-API-KEY-GOES-HERE
	  api_secret: TALKPUSH-API-SECRET-GOES-HERE

	google:
	  api_key: GOOGLE-API-KEY-GOES-HERE

## Author

[@RichOrElse](github.com/richorelse) <Ritchie Paul Buitre ritchie@richorelse.com>
