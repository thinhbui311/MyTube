module ApplicationHelper
  def flash_messages(opts = {})
    close_button = '<svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
      <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
    </svg>'
    close_button = raw(close_button)
    ignore_types = ["order_completed"].concat(Array(opts[:ignore_types]).map(&:to_s) || [])
    flash.each do |msg_type, text|
      alert_color = case msg_type
        when "error", "alert"
          "bg-red-200"
        when "success", "notice"
          "bg-green-200"
        end

      unless ignore_types.include?(msg_type)
        concat(
          content_tag(:div, "x-data": "{open: true}", "x-show": "open", "@click.outside": "open = false", "x-init": "setTimeout(() => open = false, 2500)",
            class: "#{alert_color} text-sm text-gray-500 ml-auto shadow-lg m-3 rounded-lg p-3 flex flex-row gap-2 w-60 justify-start justify-between",
            "x-transition:enter": "transition ease-out duration-200", "x-transition:enter-start": "opacity-0 -translate-x-1",
            "x-transition:enter-end": "opacity-100 translate-x-0", "x-transition:leave": "transition ease-in duration-150",
            "x-transition:leave-start": "opacity-100 translate-x-0", "x-transition:leave-end": "opacity-0 -translate-x-1") do
            content_tag(:div, class: "space-y-1") do
              content_tag(:p, msg_type, class: "capitalize font-medium text-gray-600") + content_tag(:p, text)
            end +
              content_tag(:button, close_button, class: "text-gray-500 hover:text-gray-700", "@click": "open = ! open")
          end
        )
      end
    end
    nil
  end
end
