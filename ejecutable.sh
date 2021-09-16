#userid -- ORACLE username/password@IP:PUERTO/SID
#control -- control file name
#log -- log file name
#bad -- bad file name
echo "Iniciara la Carga de Datos "
echo -e "\e[96m  ENTER PARA CONTINUAR ... \e[0m"
read
sqlldr userid=edson/1234@localhost:1521/xe control=control.ctl log=log/output.ctl bad=bad/ctlbad.ctl
echo -e "\e[96m  Termino La Carga de Datos ENTER ... \e[0m"
read
