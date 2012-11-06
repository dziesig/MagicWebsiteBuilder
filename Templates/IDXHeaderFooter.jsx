
function file_name_only(str)
{
  var slash = '/'
  if (str.match(/\\/))
  {
    slash = '\\'
  }
  return str.substring(str.lastIndexOf(slash) + 1, str.length)
}

function TCW_IDXHeader()
{
  var filename = file_name_only(location.href);
  var answer = "";
  if (filename == ""){}
/* ZZZZZ IDX Header ZZZZZ */

  document.write(answer);
}

function TCW_IDXFooter()
{
  var filename = file_name_only(location.href);
  var answer = "";
  if (filename == ""){}
/* ZZZZZ IDX Footer ZZZZZ */

  document.write(answer);
}
