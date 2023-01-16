class SpicesController < ApplicationController

    def index 
        render json: Spice.all, except: [:created_at, :updated_at, :show], status: :ok
    end

    def create 
        spice = Spice.new(spice_params)
        spice.save
        render json: spice, status: :created
    end

    def update
        spice = Spice.find_by(id:params[:id])
        if spice
            spice.update( spice_params )
            render json: spice, status: :ok
        else 
            spice_not_found
        end

    end

    def destroy
        spice = Spice.find_by(id:params[:id])
        if spice
            spice.destroy
            head :no_content
        else    
            spice_not_found
        end
    end

    private 

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def spice_not_found
        render json: { errors: ['Spice not found'] }, status: :not_found 
    end
end
