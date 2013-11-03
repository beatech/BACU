module BacuMarkdownHelper
  def markdown(text)
    unless @markdown
      bacu_renderer = Redcarpet::Render::BacuHTML.new(hard_wrap: true, filter_html: true)
      @markdown = Redcarpet::Markdown.new(bacu_renderer, tables: true, lax_spacing: true)
    end

    @markdown.render(text).html_safe
  end

  def render_wiki_content(entry)
    return '' unless entry && entry.content
    markdown(entry.content)
  end
end
