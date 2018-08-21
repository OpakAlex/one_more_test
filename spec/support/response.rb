module Response
  def json_body
    @json_body ||= JSON.parse(subject.body)
  end

  def inspect
    "<Response(#{status})>"
  end
end
