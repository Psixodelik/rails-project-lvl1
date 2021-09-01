# [![Actions Status](https://github.com/Psixodelik/rails-project-lvl1/workflows/hexlet-check/badge.svg)](https://github.com/Psixodelik/rails-project-lvl1/actions)


# HexletCode

HexletCode - Gem for generating HTML forms

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

### Create field structure

```ruby
User = Struct.new(:name, :job, keyword_init: true)
user = User.new job: 'hexlet'
```

### Create an empty form

```ruby
HexletCode.form_for user do |tag|
  # Code
end
```

### Creating forms elements

Two methods are used to create form fields:

* `input` to create` input`, `textarea` and` select`. The `as` parameter is used to select the type
* `submit` to create a button

**Example**

```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
  f.input :gender, as: :select, collection: %w[m f]
  f.submit
end
```

```html
<form action="#" method="post">
  <label for="name">Name</label>
  <input type="text" name="name" value="rob">

  <label for="job">Job</label>
  <textarea cols="20" rows="40" name="job">hexlet</textarea>

  <select name="gender">
    <option value="m" selected>m</option>
    <option value="f">f</option>
  </select>

  <input type="submit" value="Save" name="commit">
</form>
```

### Creating other elements

To create other elements, use the `build` method of the `Tag` class.

The method takes:

* Tag name
* Options

**Example**

```ruby
HexletCode::Tag.build('br') # -> <br>
HexletCode::Tag.build('img', src: 'path/to/image') # -> <img src="path/to/image">
```

The method can take a block that will be placed inside the tag

```ruby
HexletCode::Tag.build('label', for: 'email') { 'Email' } # -> <label for="email">Email</label>
```