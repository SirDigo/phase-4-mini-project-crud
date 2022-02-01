class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    #GET /spices
    def index
        render json: Spice.all
    end

    #Post /spices
    def create
        spice = Spice.create(spice_perams)
        render json: spice, status: :created
    end

    #PATCH /spices/:id
    def update
        spice = find_spice
        spice.update(spice_perams)
        render json: spice
    end

    #DELETE /spices/:id
    def destroy
        find_spice.destroy
        head :no_content
    end

    private

    def find_spice
        Spice.find_by(id: params[:id])
    end

    def spice_perams
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found
        render json: { error: "Spice not found" }, status: :render_not_found
    end

end
