define vim::rc ($content='', $order=75)
{
  validate_string($content)

  $real_content = $content ? {
    ''       => $name,
    default  => $content
  }

  concat::fragment { "vimrc-${name}":
    target  => 'vimrc',
    content => "${real_content}\n",
    order   => $order,
  }
}
