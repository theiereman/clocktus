class MoodsController < ApplicationController
  def create
    @mood = Current.user.moods.find_or_initialize_by(date: mood_params[:date])

    if @mood.update(level: mood_params[:level])
      render turbo_stream: [
        turbo_stream.replace("mood_form", partial: "activities/mood_form", locals: { date: @mood.date, mood: @mood }),
        helpers.turbo_flash_toast(:notice, t("activities.mood_form.saved"))
      ]
    else
      render turbo_stream: helpers.turbo_flash_toast(:alert, @mood.errors.full_messages.first)
    end
  end

  private

  def mood_params
    params.expect(mood: [ :date, :level ])
  end
end
