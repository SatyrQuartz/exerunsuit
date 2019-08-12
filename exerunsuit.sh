#!/bin/bash
exerunsuit_prog_dos="emu2"
exerunsuit_prog_win="wine"
exerunsuit_prog_dotnet="mono"
exerunsuit_prog_os2="lx_loader"

exerunsuit_exe_path="$1"

exerunsuit_exe_type="$(file "$exerunsuit_exe_path")"

exerunsuit_arch="$(arch)"

EMU2_DRIVE_C=''
EMU2_CWD='C:\'
EMU2_DEFAULT_DRIVE='C:\'


if [[ $exerunsuit_exe_type == *".Net assembly"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    echo "OS:.NET Framework | CPU:all | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    echo "OS:.NET Framework | CPU:all | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  echo "OS:.NET Framework | CPU:all | Runner:$exerunsuit_prog_dotnet"
  $exerunsuit_prog_dotnet "$@"
  exit
fi

if [[ $exerunsuit_exe_type == *"(Windows CE)"* ]]; then
  if [[ $exerunsuit_exe_type == *"(Windows CE) ARM"* ]]; then
    echo "OS:Windows CE | CPU:armhf | Runner:NONE!"
    exit
  fi
  if [[ $exerunsuit_exe_type == *"(Windows CE) Intel 80386"* ]]; then
    echo "OS:Windows CE | CPU:i386 | Runner:NONE!"
    exit
  fi
  if [[ $exerunsuit_exe_type == *"(Windows CE) MIPS R4000"* ]]; then
    echo "OS:Windows CE | CPU:mips | Runner:NONE!"
    exit
  fi
  if [[ $exerunsuit_exe_type == *"(Windows CE) Hitachi SH3"* ]]; then
    echo "OS:Windows CE | CPU:sh3 | Runner:NONE!"
    exit
  fi
fi

if [[ $exerunsuit_exe_type == *"x86-64"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    echo "OS:Windows NT | CPU:amd64 | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    echo "OS:Windows NT | CPU:amd64 | Runner:NONE!"
    exit
  fi
  echo "OS:Windows NT | CPU:amd64 | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"Intel 80386"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    echo "OS:Windows NT | CPU:i386 | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    echo "OS:Windows NT | CPU:i386 | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  echo "OS:Windows NT | CPU:i386 | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable, NE for MS Windows 3.x"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    echo "OS:Windows 3.x | CPU:i386 | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    echo "OS:Windows 3.x | CPU:i386 | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
  fi
  echo "OS:Windows 3.x | CPU:i386 | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable, LX for OS/2"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    echo "OS:OS/2 2.x | CPU:i386 | Runner:$exerunsuit_prog_os2"
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    echo "OS:OS/2 2.x | CPU:i386 | Runner:$exerunsuit_prog_os2"
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  echo "OS:OS/2 2.x | CPU:i386 | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable, NE for OS/2 1.x"* ]]; then
  if [[ $exerunsuit_arch == *"x86_64"* ]]; then
    echo "OS:OS/2 1.x | CPU:i386 | Runner:$exerunsuit_prog_os2"
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  if [[ $exerunsuit_arch == "i"* ]]; then
    echo "OS:OS/2 1.x | CPU:i386 | Runner:$exerunsuit_prog_os2"
    $exerunsuit_prog_os2 "$@"
    exit
  fi
  echo "OS:OS/2 1.x | CPU:i386 | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"MS-DOS executable"* ]]; then
  echo "OS:MS-DOS | CPU:i386 | Runner:$exerunsuit_prog_dos"
  $exerunsuit_prog_dos "$@"
  exit
fi

if [[ $exerunsuit_exe_type == *"COM executable for DOS"* ]]; then
  echo "OS:MS-DOS | CPU:i386 | Runner:$exerunsuit_prog_dos"
  $exerunsuit_prog_dos "$@"
  exit
fi

if [[ $exerunsuit_exe_type == *"ARMv7 Thumb"* ]]; then
  if [[ $exerunsuit_arch == "arm"* ]]; then
  echo "OS:Windows NT | CPU:armhf | Runner:$exerunsuit_prog_win"
  $exerunsuit_prog_win "$@"
  exit
  fi
  if [[ $exerunsuit_arch == "aarch64"* ]]; then
  echo "OS:Windows NT | CPU:armhf  | Runner:$exerunsuit_prog_win"
  $exerunsuit_prog_win "$@"
  exit
  fi
  echo "OS:Windows NT | CPU:armhf | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"Alpha"* ]]; then
  echo "OS:Windows NT | CPU:alpha | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"Intel Itanium"* ]]; then
  echo "OS:Windows NT | CPU:ia64 | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"MIPS R4000"* ]]; then
  echo "OS:Windows NT | CPU:mips | Runner:NONE!"
  exit
fi


if [[ $exerunsuit_exe_type == *"PowerPC"* ]]; then
  echo "OS:Windows NT | CPU:powerpc | Runner:NONE!"
  exit
fi

if [[ $exerunsuit_exe_type == *"PE32+ executable"* ]]; then
    if [[ $exerunsuit_arch == "aarch64"* ]]; then
    echo "OS:Windows NT | CPU:?  | Runner:$exerunsuit_prog_win"
    $exerunsuit_prog_win "$@"
    exit
    fi
  echo "OS:Windows NT | CPU:? | Runner:NONE!"
  exit
fi
