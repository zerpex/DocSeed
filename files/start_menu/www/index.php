<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Start Page</title>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/mystartpage.css"/>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
  </head>
  <body>
    <div class="h1">
        MySeedbox
    </div>
    <div>
      <form method="get" action="https://www.google.fr/#q=" target="_blank">
        <input class="search" name="g" type="text" placeholder="Google">
      </form>
    </div>
    <div>
      <form method="get" action="https://www.qwant.com/?q=">
        <input class="search" name="q" type="text" placeholder="Qwant">
      </form>
    </div>
	<div class="row">
	  <table class="table">
		<tbody>
		<tr class="h2">
		  <th>Download</th>
		  <th>Automation</th>
		</tr>
		<tr>
		  <td><div class="column"><?php include("dl.html"); ?></div></td>
		  <td><div class="column"><?php include("autodl.html"); ?></div></td>
		</tr>
		</tbody>
	  </table>
	</div>
	<div class="row">
	  <table class="table">
		<tbody>
		<tr class="h2">
		  <th>Streaming</th>
		  <th>Tools</th>
		</tr>
		<tr>
		  <td><div class="column"><?php include("stream.html"); ?></div></td>
		  <td><div class="column"><?php include("tools.html"); ?></div></td>
		</tr>
		</tbody>
	  </table>
	</div>
<div class="normal">
  Writen by <a href="mailto:zerpex@gmail.com" class="pink">zerpex</a>. Fork me on <a ref="https://github.com/zerpex/seedbox_docker" target="_blank" class="pink">github</a> !
</div>
  </body>
</html>

