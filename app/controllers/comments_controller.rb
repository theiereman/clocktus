class CommentsController < ApplicationController
  def create
    @comment = Current.user.comments.find_or_initialize_by(date: comment_params[:date])

    if comment_params[:body].blank?
      if @comment.persisted?
        @comment.destroy
        render turbo_stream: helpers.turbo_flash_toast(:notice, t("activities.comment_form.deleted"))
      else
        head :ok, content_type: "text/vnd.turbo-stream.html"
      end
    elsif @comment.update(body: comment_params[:body])
      render turbo_stream: helpers.turbo_flash_toast(:notice, t("activities.comment_form.saved"))
    else
      render turbo_stream: helpers.turbo_flash_toast(:alert, @comment.errors.full_messages.first)
    end
  end

  private

  def comment_params
    params.expect(comment: [ :date, :body ])
  end
end
