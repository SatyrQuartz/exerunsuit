#!/bin/bash
exerunsuit_prog_dos="emu2"
exerunsuit_prog_win="wine"
exerunsuit_prog_dotnet="mono"
exerunsuit_prog_os2="lx_loader"

exerunsuit_exe_path=$1

exerunsuit_exe_type="$(file "$exerunsuit_exe_path")"

exerunsuit_arch="$(arch)"

EMU2_DRIVE_C=''
EMU2_CWD='C:\'
EMU2_DEFAULT_DRIVE='C:\'

[ -z "$exerunsuit_verbose" ] && exerunsuit_verbose=0
[ -z "$exerunsuit_prefermonoexerunsuit_prefermono" ] && exerunsuit_prefermono=0

exerunsuit_verbose () {
  if [[ $exerunsuit_verbose == 1 ]]; then
    echo "OS:$1 | CPU:$2 | Runner:$3"
  fi
}

exerunsuit_rundotnet () {
  if [[ $exerunsuit_prefermono == 0 ]]; then
    exerunsuit_verbose ".NET Framework" all $exerunsuit_prog_win
    $exerunsuit_prog_win $exerunsuit_exe_path
  fi
  if [[ $exerunsuit_prefermono == 1 ]]; then
    exerunsuit_verbose ".NET Framework" all $exerunsuit_prog_dotnet
    $exerunsuit_prog_dotnet $exerunsuit_exe_path
  fi
}

if [[ $exerunsuit_exe_type == *".Net assembly"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    exerunsuit_rundotnet
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    exerunsuit_rundotnet
    exit
  fi
  exerunsuit_verbose ".NET Framework" all $exerunsuit_prog_dotnet
  $exerunsuit_prog_dotnet "$@"
  exit
fi

if [[ $exerunsuit_exe_type == *"(Windows CE)"* ]]; then
  if [[ $exerunsuit_exe_type == *"(Windows CE) ARM"* ]]; then
    exerunsuit_verbose "Windows CE" armhf NONE!
    exit
  fi
  if [[ $exerunsuit_exe_type == *"(Windows CE) Intel 80386"* ]]; then
    exerunsuit_verbose "Windows CE" i386 NONE!
    exit
  fi
  if [[ $exerunsuit_exe_type == *"(Windows CE) MIPS R4000"* ]]; then
    exerunsuit_verbose "Windows CE" mips NONE!
    exit
  fi
  if [[ $exerunsuit_exe_type == *"(Windows CE) Hitachi SH3"* ]]; then
    exerunsuit_verbose "Windows CE" sh3 NONE!
    exit
  fi
fi

if [[ $exerunsuit_exe_type == *"x86-64"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    exerunsuit_verbose "Windows NT" amd64 $exerunsuit_prog_win
    $exerunsuit_prog_win "$@"
    exit
  fi
  exerunsuit_verbose "Windows NT" amd64 NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"Intel 80386"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    exerunsuit_verbose "Windows NT" i386 $exerunsuit_prog_win
    $exerunsuit_prog_win "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    exerunsuit_verbose "Windows NT" i386 $exerunsuit_prog_win
    $exerunsuit_prog_win "$@"
    exit
  fi
  exerunsuit_verbose "Windows NT" i386 NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable, NE for MS Windows 3.x"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    exerunsuit_verbose "Windows 3.x" i386 $exerunsuit_prog_win
    $exerunsuit_prog_win "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    exerunsuit_verbose "Windows 3.x" i386 $exerunsuit_prog_win
    $exerunsuit_prog_win "$@"
    exit
  fi
  exerunsuit_verbose "Windows 3.x" i386 NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable, LX for OS/2"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    exerunsuit_verbose "OS/2 2.x" i386 $exerunsuit_prog_os2
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    exerunsuit_verbose "OS/2 2.x" i386 $exerunsuit_prog_os2
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  exerunsuit_verbose "OS/2 2.x" i386 NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable, NE for OS/2 1.x"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    exerunsuit_verbose "OS/2 1.x" i386 $exerunsuit_prog_os2
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    exerunsuit_verbose "OS/2 1.x" i386 $exerunsuit_prog_os2
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  exerunsuit_verbose "OS/2 1.x" i386 NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable"* ]]; then
  exerunsuit_verbose MS-DOS i386 $exerunsuit_prog_dos
  $exerunsuit_prog_dos "$@"
  exit
fi

if [[ $exerunsuit_exe_type == *"COM executable for DOS"* ]]; then
  exerunsuit_verbose MS-DOS i386 $exerunsuit_prog_dos
  $exerunsuit_prog_dos "$@"
  exit
fi

if [[ $exerunsuit_exe_type == *"ARMv7 Thumb"* ]]; then
  if [[ $exerunsuit_arch == "arm"* ]]; then
  exerunsuit_verbose "Windows NT" armhf $exerunsuit_prog_win
  $exerunsuit_prog_win "$@"
  exit
  fi
  if [[ $exerunsuit_arch == "aarch64"* ]]; then
  exerunsuit_verbose "Windows NT" armhf $exerunsuit_prog_win
  $exerunsuit_prog_win "$@"
  exit
  fi
  exerunsuit_verbose "Windows NT" armhf NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"Alpha"* ]]; then
  exerunsuit_verbose "Windows NT" alpha NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"Intel Itanium"* ]]; then
  exerunsuit_verbose "Windows NT" ia64 NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"MIPS R4000"* ]]; then
  exerunsuit_verbose "Windows NT" mips NONE!
  exit
fi


if [[ $exerunsuit_exe_type == *"PowerPC"* ]]; then
  exerunsuit_verbose "Windows NT" powerpc NONE!
  exit
fi

if [[ $exerunsuit_exe_type == *"PE32+ executable"* ]]; then
    if [[ $exerunsuit_arch == "aarch64"* ]]; then
    exerunsuit_verbose "Windows NT" "arm64 or unknown" $exerunsuit_prog_win
    $exerunsuit_prog_win "$@"
    exit
    fi
  exerunsuit_verbose "Windows NT" "arm64 or unknown" NONE!
  exit
fi
