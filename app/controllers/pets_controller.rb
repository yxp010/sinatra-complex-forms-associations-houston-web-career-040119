class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.update(owner_id: Owner.create(params[:owner]).id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    pet = current_pet

    if !params[:pet][:owner_id].empty?
      pet.update(params[:pet])
    end

    if !params[:owner][:name].empty?
      pet.update(owner_id: Owner.create(params[:owner]).id)
    end

    redirect "pets/#{pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = current_pet
    @owners = Owner.all

    erb :'/pets/edit'
  end

  def current_pet
    Pet.find(params[:id])
  end
end
