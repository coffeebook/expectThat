<html>
<head>
  <meta charset="utf-8">
  <title>Mocha Tests</title>
  <link rel="stylesheet" href="https://raw.github.com/visionmedia/mocha/master/mocha.css" />
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
  <script src="https://raw.github.com/visionmedia/mocha/master/mocha.js"></script>
  <script type="text/javascript" src="expectThat.mocha.js"></script>
  <script>mocha.setup('bdd')</script>
  <script src="example.spec.js"></script>
  <script>
    $(function () {
      mocha
        .run()
        .globals(['foo', 'bar']) // acceptable globals
    })
  </script>
</head>
<body>
  <div id="mocha"></div>
</body>
</html>