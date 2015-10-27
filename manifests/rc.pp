define vim::rc ($content='')
{
  validate_string($content)

  $real_content = $content ? {
    ''       => $name,
    default  => $content
  }

  concat::fragment { "vimrc-${name}":
    target  => 'vimrc',
    content => "${real_content}\n",
  }
}
