
class AtatusFormatter
  def initialize(old_formatter = nil)
    @old_formatter = old_formatter || proc { |severity, datetime, progname, msg|
      "#{datetime.utc.iso8601} #{severity} #{progname}: #{msg}\n"
    }
    @tag_stack = []
  end

  def call(severity, datetime, progname, msg)
    
    message = msg.respond_to?(:to_s) ? msg.to_s : msg.inspect

    
    transaction = Atatus.current_transaction rescue nil
    span = Atatus.current_span rescue nil

    atatus_info = if transaction && span
      "atatus_apm={:transactionId=>\"#{transaction.id}\", :spanId=>\"#{span.id}\", :traceId=>\"#{transaction.trace_id}\"}"
    else
      "atatus_apm={:transactionId=>nil, :spanId=>nil, :traceId=>nil}"
    end

    
    tags_prefix = @tag_stack.flatten.compact.any? ? "[#{@tag_stack.flatten.join(',')}]" : ""

    
    combined_msg = "#{atatus_info} #{tags_prefix} #{message}"

    @old_formatter.call(severity, datetime, progname, combined_msg)
  end

  
  def push_tags(*tags)
    @tag_stack.push(tags)
  end

  def pop_tags
    @tag_stack.pop
  end
end


# old = Rails.logger.formatter rescue nil
# Rails.logger.formatter = AtatusFormatter.new(old)
