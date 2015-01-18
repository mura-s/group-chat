# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  last_message_id = -1
  group_id = -1

  $(".my-group").click ->
    group_id = parseInt($(this).attr("id"))

    # alert
    $("p.alert").remove()

    # 参加グループ
    $(".my-group.active").removeClass("active")
    $(this).addClass("active")

    # チャットエリア
    $(".send-button").removeClass("disabled")
    create_timeline()

    # グループ編集、抜ける
    $(".group-setting,.leave-group").removeClass("disabled")
    $(".group-setting").attr("href", "/groups/#{group_id}/edit")
    $(".leave-group").attr("href", "/groups/#{group_id}/leave")

    # メンバー
    create_member_area()

  $(".send-button").click ->
    content = $(".message-post-area").val()
    return if content.trim() is ""

    $.ajax {
      url: "/api/groups/#{group_id}/messages",
      type: "POST",
      dataType: "json",
      data: { content: content }
      success: (data) ->
        $(".message-post-area").val("")
        message = data.message
        $(".timeline-body").prepend(
          create_timeline_item(message.name, message.created_at, message.content)
            .addClass("my-post-item") # フォームから投稿したメッセージにしるしを付けておく
        )
    }

    this.blur()

  # ポーリングしてメッセージを取得する
  setInterval ->
    if $(".timeline").size() isnt 0 and $(".group-not-selected").size() is 0
      $.get "/api/groups/#{group_id}/messages/#{last_message_id}", (data) ->
        $(".my-post-item").remove()
        after_success_get_messages(data)
  , 5000

  create_timeline = ->
    $(".timeline-body").empty()
    $.get "/api/groups/#{group_id}/messages", (data) ->
      after_success_get_messages(data)

  after_success_get_messages = (data) ->
    for message in data.messages
      $(".timeline-body").prepend(
        create_timeline_item(message.name, message.created_at, message.content)
      )
    last_message_id = data.last_message_id

  create_timeline_item = (name, time, content) ->
    item = $("<li class='list-group-item'></li>")
      .append("<div class='header'><em>#{name} (#{time})</em></div>")
    for line in content.split("\n")
      item.append("<div class='body'><strong>#{line}</strong></div>")

  create_member_area = ->
    $(".group-member").empty()
    $.get "/api/groups/#{group_id}/members", (data) ->
      for member in data.members
        $(".group-member").append("<li class='list-group-item'>#{member.name}</li>")
