# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* test git mac salon avec le remote


- @product.main_pict.each do |picture|
	= image_tag(picture.url)
	= link_to "Delete", admin_product_main_picture_path(@product.id), method: :delete, data: { confirm: "Are you sure you want to delete this picture?" }

%h2= 'Change main picture'
= form_for @product, url: admin_product_main_pictures_path(@product.id), method: :post do |g|
	= g.file_field :main_pict
	= g.submit "Change main picture"

- @product.pictures.each_with_index do |picture, index| #grab the index
	= image_tag(picture.url)
	= link_to "Delete", admin_product_picture_path(@product.id, index), method: :delete, data: { confirm: "Are you sure you want to delete this picture?" }

%h2= 'Add more pictures'
= form_for @product, url: admin_product_pictures_path(@product.id), method: :post do |g|
	= g.file_field :pictures, multiple: true
	= g.submit "Add More pictures"