# Provet::Client

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/provet/client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'provet-client', require: false
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install provet-client

## Configuration

```ruby
require 'provet'

Provet.host = "https://us.provetcloud.com" # optional
Provet.api_version = "0.1" # optional
Provet.instance = 123 # required
Provet.token = "your_provet_token" # required
```

## Usage

Every resource available in the ProvetCloud API is mapped with a corresponding class inheriting from `Provet::Base`, which contains the necessary methods to properly consume the API endpoints.

The classes are :
- Provet::Appointment
- Provet::Availability
- Provet::Client
- Provet::ConsultationDischargeInstructions
- Provet::ConsultationItemTemplate
- Provet::ConsultationItem
- Provet::Consultation
- Provet::Department
- Provet::InvoiceRow
- Provet::Invoice
- Provet::ItemList
- Provet::ItemTemplateItem
- Provet::ItemTemplate
- Provet::Item
- Provet::LaboratoryAnalysisGroup
- Provet::Patient
- Provet::PhoneNumber
- Provet::ReasonGroup
- Provet::Reason
- Provet::ReminderTemplate
- Provet::Reminder
- Provet::UserDetails
- Provet::UserGroup
- Provet::User
- Provet::VatGroup

On each of the aforementioned classes you can call the following methods:

### `.base_uri`

Returns the base URI of the Provet API. Depends on the Provet instance present in the Rails credentials.
Example :

```ruby
Provet::Base.base_uri
# => "https://us.provetcloud.com/1234/api/0.1" in staging
```

### `#list`

Returns a list of the designated provet resource. It is paginated by default.
Example :

```ruby
res = Provet::Client.new.list
res.parsed_response
# => {"count"=>4223, "num_pages"=>85, "next"=>"https://us.provetcloud.com/1234/api/0.1/client/?page=2", "previous"=>nil, "results"=>[{"id"=>1, "url"=>"https://us.provetcloud.com/1234/api/0.1/client/1/", "title"=>nil, "firstname"=>"Helmut", "lastname"=>"Eldridge", "organization_name"=>"", "customer_type"=>0, "vat_number"=>"", "register_number"=>nil, "home_department"=>"https://us.provetcloud.com/1234/api/0.1/department/1/", "due_date_delay"=>nil, "street_address"=>"Job Str.", "street_address_2"=>nil, "street_address_3"=>nil, "zip_code"=>"W11 2BQ", "city"=>"London", "state"=>nil, "email"=>"", "alt_emails"=>nil, "id_number"=>"", "old_client_id"=>nil, "critical_notes"=>nil, "critical_accounting_notes"=>nil, "remarks"=>"", "archived"=>true, "country"=>"", "no_sms"=>false, "no_email"=>false, "external"=>false, "referring_organization"=>false, "parent_referring_organization"=>nil, "referring_vet"=>false, "imported"=>false, "date_imported"=>nil, "patients"=>[], "invoicing_client"=>nil, "tags_rel"=>[], "created"=>"2018-03-26T20:16:25-04:00", "created_user"=>nil, "modified"=>"2021-06-25T14:13:26-04:00", "modified_user"=>"https://us.provetcloud.com/1234/api/0.1/user/8/", "phone_numbers"=>[], "status_type"=>0, "fields_rel"=>[], "farm_code"=>nil, "holdingplacenumbers"=>[], "communication_preferences"=>nil, "production_animal_client"=>false}, # [...]]}
```

### `#all`

Calls `#list` as many times as there are pages and returns one array with all related resources. Use with caution if many records.

Example :
```ruby
all_provet_clients = Provet::Client.new.all
# => [{"id"=>1, "url"=>"https://us.provetcloud.com/1234/api/0.1/client/1/", "title"=>nil, "firstname"=>"Helmut", "lastname"=>"Eldridge", "organization_name"=>"", "customer_type"=>0, "vat_number"=>"", "register_number"=>nil, "home_department"=>"https://us.provetcloud.com/1234/api/0.1/department/1/", "due_date_delay"=>nil, "street_address"=>"Job Str.", "street_address_2"=>nil, "street_address_3"=>nil, "zip_code"=>"W11 2BQ", "city"=>"London", "state"=>nil, "email"=>"", "alt_emails"=>nil, "id_number"=>"", "old_client_id"=>nil, "critical_notes"=>nil, "critical_accounting_notes"=>nil, "remarks"=>"", "archived"=>true, "country"=>"", "no_sms"=>false, "no_email"=>false, "external"=>false, "referring_organization"=>false, "parent_referring_organization"=>nil, "referring_vet"=>false, "imported"=>false, "date_imported"=>nil, "patients"=>[], "invoicing_client"=>nil, "tags_rel"=>[], "created"=>"2018-03-26T20:16:25-04:00", "created_user"=>nil, "modified"=>"2021-06-25T14:13:26-04:00", "modified_user"=>"https://us.provetcloud.com/1234/api/0.1/user/8/", "phone_numbers"=>[], "status_type"=>0, "fields_rel"=>[], "farm_code"=>nil, "holdingplacenumbers"=>[], "communication_preferences"=>nil, "production_animal_client"=>false}, {[...]}]
```


### `#find(id: String)`

Returns the corresponding provet resource.

```ruby
res = Provet::Client.new.find(1)
res.parsed_response
# => {"id"=>1, "url"=>"https://us.provetcloud.com/1234/api/0.1/client/1/", "title"=>nil, "firstname"=>"Helmut", "lastname"=>"Eldridge", "organization_name"=>"", "customer_type"=>0, "vat_number"=>"", "register_number"=>nil, "home_department"=>"https://us.provetcloud.com/1234/api/0.1/department/1/", "due_date_delay"=>nil, "street_address"=>"Job Str.", "street_address_2"=>nil, "street_address_3"=>nil, "zip_code"=>"W11 2BQ", "city"=>"London", "state"=>nil, "email"=>"", "alt_emails"=>nil, "id_number"=>"", "old_client_id"=>nil, "critical_notes"=>nil, "critical_accounting_notes"=>nil, "remarks"=>"", "archived"=>true, "country"=>"", "no_sms"=>false, "no_email"=>false, "external"=>false, "referring_organization"=>false, "parent_referring_organization"=>nil, "referring_vet"=>false, "imported"=>false, "date_imported"=>nil, "patients"=>[], "invoicing_client"=>nil, "tags_rel"=>[], "created"=>"2018-03-26T20:16:25-04:00", "created_user"=>nil, "modified"=>"2021-06-25T14:13:26-04:00", "modified_user"=>"https://us.provetcloud.com/1234/api/0.1/user/8/", "phone_numbers"=>[], "status_type"=>0, "fields_rel"=>[], "farm_code"=>nil, "holdingplacenumbers"=>[], "communication_preferences"=>nil, "production_animal_client"=>false}
```

### `#create(payload: JSON)`

Creates a Provet resource and returns that resource.
Example :

```ruby
payload = {
  firstname: "Luke",
  lastname: "Skywalker",
  email: "luke@example.com",
  patients: [],
}

res = Provet::Client.new.create(payload.to_json)
res.parsed_response
# => {"id"=>42, "url"=>"https://us.provetcloud.com/1234/api/0.1/client/42/", "title"=>nil, "firstname"=>"Luke", "lastname"=>"Skywalker", "organization_name"=>"", "customer_type"=>0, "vat_number"=>"", "register_number"=>nil, "home_department"=>"https://us.provetcloud.com/1234/api/0.1/department/1/", "due_date_delay"=>nil, "street_address"=>"Job Str.", "street_address_2"=>nil, "street_address_3"=>nil, "zip_code"=>"nil", "city"=>"nil", "state"=>nil, "email"=>"", "alt_emails"=>nil, "id_number"=>"", "old_client_id"=>nil, "critical_notes"=>nil, "critical_accounting_notes"=>nil, "remarks"=>"", "archived"=>true, "country"=>"", "no_sms"=>false, "no_email"=>false, "external"=>false, "referring_organization"=>false, "parent_referring_organization"=>nil, "referring_vet"=>false, "imported"=>false, "date_imported"=>nil, "patients"=>[], "invoicing_client"=>nil, "tags_rel"=>[], "created"=>"2021-03-26T20:16:25-04:00", "created_user"=>nil, "modified"=>"2021-06-25T14:13:26-04:00", "modified_user"=>nil, "phone_numbers"=>[], "status_type"=>0, "fields_rel"=>[], "farm_code"=>nil, "holdingplacenumbers"=>[], "communication_preferences"=>nil, "production_animal_client"=>false}
```

### `#update(id: String, payload: JSON)`
Updates a Provet resource and returns that resource.

```ruby
payload = {
  firstname: "Luke",
  lastname: "Skywalker",
  email: "luke@example.com",
  patients: [],
}

res = Provet::Client.new.update(1, payload.to_json)
res.parsed_response
# => {"id"=>1, "url"=>"https://us.provetcloud.com/1234/api/0.1/client/1/", "title"=>nil, "firstname"=>"Luke", "lastname"=>"Skywalker", "organization_name"=>"", "customer_type"=>0, "vat_number"=>"", "register_number"=>nil, "home_department"=>"https://us.provetcloud.com/1234/api/0.1/department/1/", "due_date_delay"=>nil, "street_address"=>"Job Str.", "street_address_2"=>nil, "street_address_3"=>nil, "zip_code"=>"nil", "city"=>"nil", "state"=>nil, "email"=>"", "alt_emails"=>nil, "id_number"=>"", "old_client_id"=>nil, "critical_notes"=>nil, "critical_accounting_notes"=>nil, "remarks"=>"", "archived"=>true, "country"=>"", "no_sms"=>false, "no_email"=>false, "external"=>false, "referring_organization"=>false, "parent_referring_organization"=>nil, "referring_vet"=>false, "imported"=>false, "date_imported"=>nil, "patients"=>[], "invoicing_client"=>nil, "tags_rel"=>[], "created"=>"2021-03-26T20:16:25-04:00", "created_user"=>nil, "modified"=>"2021-06-25T14:13:26-04:00", "modified_user"=>nil, "phone_numbers"=>[], "status_type"=>0, "fields_rel"=>[], "farm_code"=>nil, "holdingplacenumbers"=>[], "communication_preferences"=>nil, "production_animal_client"=>false}
```

### `#destroy(id: String)`

Destroys a Provet resource.
Example:

```ruby
res = Provet::Client.new.destroy(1)
```

## Additional notes

Some Provet resources are configured to be soft-deletable with this gem:
- Provet::Appointment
- Provet::Client
- Provet::Patient
- Provet::User

For these classes, calling `#destroy` will perform a `PATCH` http request to archive the resource in Provet, instead of actually erasing it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/EmCousin/provet-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/EmCousin/provet-client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Provet::Client project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/provet-client/blob/master/CODE_OF_CONDUCT.md).
