# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".my-group").click ->
    group_id = $(this).attr("id")

    # alert
    $("p.alert").remove()

    # 参加グループ
    $(".my-group.active").removeClass("active")
    $(this).addClass("active")

    # チャットエリア
    $(".send-button").removeClass("disabled")
    create_timeline(group_id)

    # グループ編集、抜ける
    $(".group-setting,.leave-group").removeClass("disabled")
    $(".group-setting").attr("href", "/groups/#{group_id}/edit")
    $(".leave-group").attr("href", "/groups/#{group_id}/leave")

    # メンバー
    create_member_area(group_id)

  $(".send-button").click ->
    group_id = $(".my-group.active").attr("id")
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
        )
    }

    this.blur()

  create_timeline = (group_id) ->
    $(".timeline-body").empty()
    $.get "/api/groups/#{group_id}/messages", (data) ->
      for message in data.messages
        $(".timeline-body").append(
          create_timeline_item(message.name, message.created_at, message.content)
        )

  create_timeline_item = (name, time, content) ->
    item = $("<li class='list-group-item'></li>")
      .append("<div class='header'><em>#{name} (#{time})</em></div>")
      .append("<div class='body'><strong>#{content}</strong></div>")

  create_member_area = (group_id) ->
    $(".group-member").empty()
    $.get "/api/groups/#{group_id}/members", (data) ->
      for member in data.members
        $(".group-member").append("<li class='list-group-item'>#{member.name}</li>")


