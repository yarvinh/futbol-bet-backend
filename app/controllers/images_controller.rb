class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]

  # POST /images or /images.json
  def create
    @user = current_user
    if @user && @user.image
      @user.image.delete
    end
    @image = Image.new({image: params[:image]})
    
    @image.user = @user
    if @user && @image.save 
      render json: UserSerializer.new({logged_in: true, user: @user,  errors_or_messages: {from: "create_user_image", msg: [ "Image was successfully created."]}}).to_serialized_json
    else 
      render json: {errors_or_messages: {from: "create_image", errors: ["Something went wrong", "Image was not created."]} }.to_json, status: :unprocessable_entity 
    end

    # respond_to do |format|
    #   if @image.save
    #     format.html { redirect_to image_url(@image), notice: "Image was successfully created." }
    #     format.json { render :show, status: :created, location: @image }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @image.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to image_url(@image), notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.fetch(:image, {})
    end
end
