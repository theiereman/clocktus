module FlashHelper
  TOAST_STYLES = {
    "notice" => "bg-background text-text border-text",
    "alert"  => "bg-primary text-text border-text"
  }.freeze

  def flash_toasts
    turbo_frame_tag :flash,
      class: "fixed bottom-6 right-2 z-50 flex flex-col items-center gap-2 px-4 pointer-events-none" do
      safe_join(flash.map { |type, message| flash_toast(type, message) })
    end
  end

  def flash_toast(type, message)
    tag.div class: "flash-toast pointer-events-auto", role: "alert", aria: { live: "polite" },
      data: { controller: "element-removal", action: "animationend->element-removal#remove" } do
      tag.div message, class: "max-w-[90vw] px-5 py-3 font-bold border-2 shadow-lg #{TOAST_STYLES[flash_kind(type)]}"
    end
  end

  def turbo_flash_toast(type, message)
    turbo_stream.append :flash, flash_toast(type, message)
  end

  private
    def flash_kind(type)
      TOAST_STYLES.key?(type.to_s) ? type.to_s : "notice"
    end
end
