module Mint
  class Formatter
    def format(node : Ast::HtmlElement) : Nodes
      tag =
        format node.tag

      prefix =
        if styles = node.styles
          tag + format(styles)
        else
          tag
        end

      ref =
        format(node.ref) do |variable|
          name =
            format variable

          [" as "] + name
        end

      format(prefix: prefix + ref, tag: tag, node: node)
    end
  end
end
