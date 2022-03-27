

BEGIN {
  file=ARGV[1]
  while(getline < file > 0){
    id[$1] = 1; 
  }
}

{
  if($1 ~ /^#/){
     print $0;
  } 
  else {
    if(id[$3]){
      print $0;
    }
  }
}


