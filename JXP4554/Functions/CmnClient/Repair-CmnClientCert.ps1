function Repair-CmnClientCert {
    [Cmdletbinding()]
    PARAM(
        [Parameter(Mandatory = $true, HelpMessage = 'List of computers to repair')]
        [String[]]$computers
    )
    foreach ($computer in $computers) {
        if (Test-Connection -ComputerName $computer -Count 1 -ErrorAction SilentlyContinue) {
            Write-Verbose -Message "Fixing $computer"
            Invoke-Command -ComputerName $computer -ScriptBlock { Get-ChildItem -Path Cert:\LocalMachine\SMS | Where-Object { $_.Subject -match '^CN=SMS, ' } | Remove-Item ; Restart-Service -Name CcmExec | Out-Null }
        }
        else { Write-Verbose -Message "Unable to contact $computer" }
    }
    Get-PSSession
}
$computers = ('SIMXDWDIGW006','SIMXDWDIGW007','SIMXDWDIGW008','SIMXDWDIGW009','SIMXDWDIGW010','SIMXDWDIGW011','SIMXDWDIGW012','SIMXDWDIGW013','SIMXDWDIGW014','SIMXDWDIGW015','SIMXDWDIGW016','SIMXDWDIGW017','SIMXDWDIGW018','SIMXDWDIGW019','SIMXDWDIGW020','SIMXDWDIGW021','SIMXDWDIGW022','SIMXDWDIGW023','SIMXDWDIGW024','SIMXDWDIGW025','SIMXDWDIGW026','SIMXDWDIGW027','SIMXDWDIGW028','SIMXDWDIGW029','SIMXDWDIGW030','SIMXDWDIGW031','SIMXDWDIGW032','SIMXDWDIGW033','SIMXDWDIGW034','SIMXDWDIGW035','SIMXDWDIGW036','SIMXDWDIGW037','SIMXDWDIGW038','SIMXDWDIGW039','SIMXDWDIGW040','SIMXDWDIGW041','SIMXDWDIGW042','SIMXDWDIGW043','SIMXDWDIGW044','SIMXDWDIGW045','SIMXDWDIGW046','SIMXDWDIGW047','SIMXDWDIGW048','SIMXDWDIGW049','SIMXDWDIGW050','SIMXDWDIGW051','SIMXDWDIGW052','SIMXDWDIGW053','SIMXDWDIGW054','SIMXDWDIGW055','SIMXDWDIGW056','SIMXDWDIGW057','SIMXDWDIGW058','SIMXDWDIGW059','SIMXDWDIGW060','SIMXDWDIGW061','SIMXDWDIGW062','SIMXDWDIGW064','SIMXDWDIGW065','SIMXDWDIGW066','SIMXDWDIGW067','SIMXDWDIGW068','SIMXDWDIGW069','SIMXDWDIGW070','SIMXDWDIGW071','SIMXDWDIGW072','SIMXDWDIGW073','SIMXDWDIGW074','SIMXDWDIGW075','SIMXDWDIGW076','SIMXDWDIGW077','SIMXDWDIGW078','SIMXDWDIGW079','SIMXDWDIGW080','SIMXDWDIGW081','SIMXDWDIGW082','SIMXDWDIGW083','SIMXDWDIGW084','SIMXDWDIGW085','SIMXDWDIGW086','SIMXDWDIGW087','SIMXDWDIGW088','SIMXDWDIGW089','SIMXDWDIGW090','SIMXDWDIGW091','SIMXDWDIGW092','SIMXDWDIGW093','SIMXDWDIGW094','SIMXDWDIGW095','SIMXDWDIGW096','SIMXDWDIGW097','SIMXDWDIGW098','SIMXDWDIGW099','SIMXDWDIGW100','SIMXDWDIGW101','SIMXDWDIGW102','SIMXDWDIGW103','SIMXDWDIGW104','SIMXDWDIGW105','SIMXDWDIGW106','SIMXDWDIGW107','SIMXDWDIGW108','SIMXDWDIGW109','SIMXDWDIGW110','SIMXDWDIGW111','SIMXDWDIGW112','SIMXDWDIGW113','SIMXDWDIGW114','SIMXDWDIGW115','SIMXDWDIGW116','SIMXDWDIGW117','SIMXDWDIGW118','SIMXDWDIGW119','SIMXDWDIGW120','SIMXDWDIGW121','SIMXDWDIGW122','SIMXDWDIGW123','SIMXDWDIGW124','SIMXDWDIGW125','SIMXDWDIGW126','SIMXDWDIGW127','SIMXDWDIGW128','SIMXDWDIGW129','SIMXDWDIGW130','SIMXDWDIGW131','SIMXDWDIGW132','SIMXDWDIGW133','SIMXDWDIGW134','SIMXDWDIGW135','SIMXDWDIGW136','SIMXDWDIGW137','SIMXDWDIGW138','SIMXDWDIGW139','SIMXDWDIGW140','SIMXDWDIGW141','SIMXDWDIGW142','SIMXDWDIGW143','SIMXDWDIGW144','SIMXDWDIGW145','SIMXDWDIGW146','SIMXDWDIGW147','SIMXDWDIGW148','SIMXDWDIGW149','SIMXDWDIGW150','SIMXDWDIGW151','SIMXDWDIGW152','SIMXDWDIGW153','SIMXDWDIGW154','SIMXDWDIGW155','SIMXDWDIGW156','SIMXDWDIGW157','SIMXDWDIGW158','SIMXDWDIGW159','SIMXDWDIGW160','SIMXDWDIGW161','SIMXDWDIGW162','SIMXDWDIGW163','SIMXDWDIGW164','SIMXDWDIGW165','SIMXDWDIGW166','SIMXDWDIGW167','SIMXDWDIGW168','SIMXDWDIGW169','SIMXDWDIGW170','SIMXDWDIGW171','SIMXDWDIGW172','SIMXDWDIGW173','SIMXDWDIGW174','SIMXDWDIGW175','SIMXDWDIGW177','SIMXDWDIGW178','SIMXDWDIGW179','SIMXDWDIGW180','SIMXDWDIGW181','SIMXDWDIGW183','SIMXDWDIGW184','SIMXDWDIGW185','SIMXDWDIGW187','SIMXDWDIGW188','SIMXDWDIGW189','SIMXDWDIGW190','SIMXDWDIGW191','SIMXDWDIGW192','SIMXDWDIGW193','SIMXDWDIGW194','SIMXDWDIGW195','SIMXDWDIGW196','SIMXDWDIGW197','SIMXDWDIGW198','SIMXDWDIGW199','SIMXDWDIGW200','SIMXDWDIGW201','SIMXDWDIGW202','SIMXDWDIGW203','SIMXDWDIGW204','SIMXDWDIGW205','SIMXDWDIGW206','SIMXDWDIGW208','SIMXDWDIGW209','SIMXDWDIGW210','SIMXDWDIGW211','SIMXDWDIGW212','SIMXDWDIGW213','SIMXDWDIGW214','SIMXDWDIGW215','SIMXDWDIGW217','SIMXDWDIGW218','SIMXDWDIGW220','SIMXDWDIGW221','SIMXDWDIGW222','SIMXDWDIGW223','SIMXDWDIGW224','SIMXDWDIGW225','SIMXDWDIGW226','SIMXDWDIGW227','SIMXDWDIGW228','SIMXDWDIGW229','SIMXDWDIGW230','SIMXDWDIGW231','SIMXDWDIGW232','SIMXDWDIGW233','SIMXDWDIGW234','SIMXDWDIGW235','SIMXDWDIGW237','SIMXDWDIGW238','SIMXDWDIGW239','SIMXDWDIGW241','SIMXDWDIGW242','SIMXDWDIGW243','SIMXDWDIGW244','SIMXDWDIGW245','SIMXDWDIGW246','SIMXDWDIGW247','SIMXDWDIGW249','SIMXDWDIGW251','SIMXDWDIGW254','SIMXDWDIGW255','SIMXDWDIGW256','SIMXDWDIGW257','SIMXDWDIGW258','SIMXDWDIGW259','SIMXDWDIGW260','SIMXDWDIGW261','SIMXDWDIGW263','SIMXDWDIGW265','SIMXDWDIGW266','SIMXDWDIGW267','SIMXDWDIGW269','SIMXDWDIGW270','SIMXDWDIGW271','SIMXDWDIGW272','SIMXDWDIGW274','SIMXDWDIGW276','SIMXDWDIGW277','SIMXDWDIGW280','SIMXDWDIGW281','SIMXDWDIGW282','SIMXDWDIGW283','SIMXDWDIGW284','SIMXDWDIGW285','SIMXDWDIGW286','SIMXDWDIGW287','SIMXDWDIGW289','SIMXDWDIGW290','SIMXDWDIGW291','SIMXDWDIGW292','SIMXDWDIGW293','SIMXDWDIGW295','SIMXDWDIGW296','SIMXDWDIGW297','SIMXDWDIGW298','SIMXDWDIGW300','SIMXDWDIGW302','SIMXDWDIGW303','SIMXDWDIGW304','SIMXDWDIGW305','SIMXDWDIGW306','SIMXDWDIGW307','SIMXDWDIGW308','SIMXDWDIGW309','SIMXDWDIGW310','SIMXDWDIGW311','SIMXDWDIGW312','SIMXDWDIGW313','SIMXDWDIGW314','SIMXDWDIGW315','SIMXDWDIGW316','SIMXDWDIGW317','SIMXDWDIGW318','SIMXDWDIGW319','SIMXDWDIGW320','SIMXDWDIGW321','SIMXDWDIGW322','SIMXDWDIGW323','SIMXDWDIGW324','SIMXDWDIGW325','SIMXDWDIGW326','SIMXDWDIGW327','SIMXDWDIGW328','SIMXDWDIGW329','SIMXDWDIGW330','SIMXDWDIGW331','SIMXDWDIGW332','SIMXDWDIGW333','SIMXDWDIGW334','SIMXDWDIGW335','SIMXDWDIGW336','SIMXDWDIGW337','SIMXDWDIGW338','SIMXDWDIGW340','SIMXDWDIGW341','SIMXDWDIGW342','SIMXDWDIGW344','SIMXDWDIGW345','SIMXDWDIGW346','SIMXDWDIGW347','SIMXDWDIGW348','SIMXDWDIGW349','SIMXDWDIGW350','SIMXDWDIGW351','SIMXDWDIGW352','SIMXDWDIGW353','SIMXDWDIGW354','SIMXDWDIGW355','SIMXDWDIGW356','SIMXDWDIGW357','SIMXDWDIGW358','SIMXDWDIGW359','SIMXDWDIGW360','SIMXDWDIGW361','SIMXDWDIGW362','SIMXDWDIGW363','SIMXDWDIGW364','SIMXDWDIGW365','SIMXDWDIGW366','SIMXDWDIGW367','SIMXDWDIGW368','SIMXDWDIGW369','SIMXDWDIGW370','SIMXDWDIGW371','SIMXDWDIGW372','SIMXDWDIGW373','SIMXDWDIGW374','SIMXDWDIGW375','SIMXDWDIGW376','SIMXDWDIGW377','SIMXDWDIGW378','SIMXDWDIGW379','SIMXDWDIGW380','SIMXDWDIGW381','SIMXDWDIGW382','SIMXDWDIGW383','SIMXDWDIGW384','SIMXDWDIGW385','SIMXDWDIGW386','SIMXDWDIGW387','SIMXDWDIGW388','SIMXDWDIGW389','SIMXDWDIGW390','SIMXDWDIGW391','SIMXDWDIGW392','SIMXDWDIGW393','SIMXDWDIGW394','SIMXDWDIGW395','SIMXDWDIGW396','SIMXDWDIGW397','SIMXDWDIGW398','SIMXDWDIGW399','SIMXDWDIGW400','SIMXDWDIGW401','SIMXDWDIGW402','SIMXDWDIGW403','SIMXDWDIGW404','SIMXDWDIGW405','SIMXDWDIGW406','SIMXDWDIGW407','SIMXDWDIGW408','SIMXDWDIGW409','SIMXDWDIGW410','SIMXDWDIGW411','SIMXDWDIGW412','SIMXDWDIGW413','SIMXDWDIGW414','SIMXDWDIGW416','SIMXDWDIGW417','SIMXDWDIGW418','SIMXDWDIGW419','SIMXDWDIGW420','SIMXDWDIGW421','SIMXDWDIGW422','SIMXDWDIGW423','SIMXDWDIGW424','SIMXDWDIGW425','SIMXDWDIGW426','SIMXDWDIGW427','SIMXDWDIGW428','SIMXDWDIGW429','SIMXDWDIGW430','SIMXDWDIGW431','SIMXDWDIGW432','SIMXDWDIGW433','SIMXDWDIGW434','SIMXDWDIGW435','SIMXDWDIGW436','SIMXDWDIGW437','SIMXDWDIGW438','SIMXDWDIGW439','SIMXDWDIGW440','SIMXDWDIGW441','SIMXDWDIGW442','SIMXDWDIGW443','SIMXDWDIGW444','SIMXDWDIGW445','SIMXDWDIGW446','SIMXDWDIGW447','SIMXDWDIGW448','SIMXDWDIGW449','SIMXDWDIGW450','SIMXDWDIGW451','SIMXDWDIGW452','SIMXDWDIGW453','SIMXDWDIGW454','SIMXDWDIGW455','SIMXDWDIGW456','SIMXDWDIGW457','SIMXDWDIGW458','SIMXDWDIGW459','SIMXDWDIGW460','SIMXDWDIGW461','SIMXDWDIGW462','SIMXDWDIGW463','SIMXDWDIGW464','SIMXDWDIGW465','SIMXDWDIGW466','SIMXDWDIGW468','SIMXDWDIGW469','SIMXDWDIGW470','SIMXDWDIGW471','SIMXDWDIGW472','SIMXDWDIGW474','SIMXDWDIGW475','SIMXDWDIGW476','SIMXDWDIGW477','SIMXDWDIGW478','SIMXDWDIGW479','SIMXDWDIGW480','SIMXDWDIGW481','SIMXDWDIGW482','SIMXDWDIGW483','SIMXDWDIGW484','SIMXDWDIGW485','SIMXDWDIGW486','SIMXDWDIGW487','SIMXDWDIGW488','SIMXDWDIGW489','SIMXDWDIGW490','SIMXDWDIGW491','SIMXDWDIGW492','SIMXDWDIGW494','SIMXDWDIGW495','SIMXDWDIGW496','SIMXDWDIGW498','SIMXDWDIGW500','SIMXDWDIGW501','SIMXDWDIGW502','SIMXDWDIGW503','SIMXDWDIGW504','SIMXDWDIGW505','SIMXDWDIGW506','SIMXDWDIGW507','SIMXDWDIGW508','SIMXDWDIGW509','SIMXDWDIGW511','SIMXDWDIGW513','SIMXDWDIGW514','SIMXDWDIGW515','SIMXDWDIGW516','SIMXDWDIGW517','SIMXDWDIGW518','SIMXDWDIGW519','SIMXDWDIGW520','SIMXDWDIGW521','SIMXDWDIGW522','SIMXDWDIGW523','SIMXDWDIGW524','SIMXDWDIGW526','SIMXDWDIGW527','SIMXDWDIGW529','SIMXDWDIGW530','SIMXDWDIGW531','SIMXDWDIGW532','SIMXDWDIGW533','SIMXDWDIGW534','SIMXDWDIGW535','SIMXDWDIGW536','SIMXDWDIGW538','SIMXDWDIGW539','SIMXDWDIGW540','SIMXDWDIGW541','SIMXDWDIGW542','SIMXDWDIGW543','SIMXDWDIGW544','SIMXDWDIGW546','SIMXDWDIGW548','SIMXDWDIGW549','SIMXDWDIGW550','SIMXDWDIGW551','SIMXDWDIGW552','SIMXDWDIGW553','SIMXDWDIGW554','SIMXDWDIGW555','SIMXDWDIGW556','SIMXDWDIGW557','SIMXDWDIGW560','SIMXDWDIGW561','SIMXDWDIGW562','SIMXDWDIGW563','SIMXDWDIGW564','SIMXDWDIGW565','SIMXDWDIGW566','SIMXDWDIGW567','SIMXDWDIGW568','SIMXDWDIGW570','SIMXDWDIGW572','SIMXDWDIGW573','SIMXDWDIGW574','SIMXDWDIGW575','SIMXDWDIGW576','SIMXDWDIGW577','SIMXDWDIGW578','SIMXDWDIGW579','SIMXDWDIGW580','SIMXDWDIGW582','SIMXDWDIGW583','SIMXDWDIGW584','SIMXDWDIGW585','SIMXDWDIGW586','SIMXDWDIGW587','SIMXDWDIGW588','SIMXDWDIGW589','SIMXDWDIGW590','SIMXDWDIGW591','SIMXDWDIGW592','SIMXDWDIGW593','SIMXDWDIGW595','SIMXDWDIGW596','SIMXDWDIGW597','SIMXDWDIGW598','SIMXDWDIGW599','SIMXDWDIGW600','SIMXDWDIGW601','SIMXDWDIGW602','SIMXDWDIGW604','SIMXDWDIGW605','SIMXDWDIGW606','SIMXDWDIGW607','SIMXDWDIGW608','SIMXDWDIGW609','SIMXDWDIGW610','SIMXDWDIGW611','SIMXDWDIGW612','SIMXDWDIGW614','SIMXDWDIGW616','SIMXDWDIGW618','SIMXDWDIGW619','SIMXDWDIGW622','SIMXDWDIGW623','SIMXDWDIGW624','SIMXDWDIGW626','SIMXDWDIGW627','SIMXDWDIGW629','SIMXDWDIGW630','SIMXDWDIGW632','SIMXDWDIGW634','SIMXDWDIGW635','SIMXDWDIGW636','SIMXDWDIGW637','SIMXDWDIGW638','SIMXDWDIGW640','SIMXDWDIGW641','SIMXDWDIGW643','SIMXDWDIGW644','SIMXDWDIGW645','SIMXDWDIGW646','SIMXDWDIGW648','SIMXDWDIGW649','SIMXDWDIGW650','SIMXDWDIGW651','SIMXDWDIGW652','SIMXDWDIGW653','SIMXDWDIGW654','SIMXDWDIGW655','SIMXDWDIGW656','SIMXDWDIGW657','SIMXDWDIGW658','SIMXDWDIGW659','SIMXDWDIGW660','SIMXDWDIGW661','SIMXDWDIGW662','SIMXDWDIGW663','SIMXDWDIGW664','SIMXDWDIGW665','SIMXDWDIGW666','SIMXDWDIGW668','SIMXDWDIGW670','SIMXDWDIGW672','SIMXDWDIGW673','SIMXDWDIGW674','SIMXDWDIGW676','SIMXDWDIGW677','SIMXDWDIGW678','SIMXDWDIGW680','SIMXDWDIGW681','SIMXDWDIGW683','SIMXDWDIGW684','SIMXDWDIGW685','SIMXDWDIGW686','SIMXDWDIGW687','SIMXDWDIGW688','SIMXDWDIGW689','SIMXDWDIGW690','SIMXDWDIGW692','SIMXDWDIGW693','SIMXDWDIGW695','SIMXDWDIGW698','SIMXDWDIGW699','SIMXDWDIGW700','SIMXDWDIGW701','SIMXDWDIGW702','SIMXDWDIGW703','SIMXDWDIGW704','SIMXDWDIGW706','SIMXDWDIGW707','SIMXDWDIGW708','SIMXDWDIGW710','SIMXDWDIGW712','SIMXDWDIGW714','SIMXDWDIGW715','SIMXDWDIGW716','SIMXDWDIGW717','SIMXDWDIGW718','SIMXDWDIGW719','SIMXDWDIGW720','SIMXDWDIGW725','SIMXDWDIGW726','SIMXDWDIGW728','SIMXDWDIGW729','SIMXDWDIGW731','SIMXDWDIGW733','SIMXDWDIGW734','SIMXDWDIGW735','SIMXDWDIGW736','SIMXDWDIGW737','SIMXDWDIGW738','SIMXDWDIGW739','SIMXDWDIGW740','SIMXDWDIGW742','SIMXDWDIGW743','SIMXDWDIGW744','SIMXDWDIGW747','SIMXDWDIGW748','SIMXDWDIGW749','SIMXDWDIGW750','SIMXDWDIGW752','SIMXDWDIGW753','SIMXDWDIGW754','SIMXDWDIGW755','SIMXDWDIGW756','SIMXDWDIGW757','SIMXDWDIGW758','SIMXDWDIGW759','SIMXDWDIGW761','SIMXDWDIGW764','SIMXDWDIGW765','SIMXDWDIGW767','SIMXDWDIGW768','SIMXDWDIGW770','SIMXDWDIGWP01','SIMXDWDIGWP02','SIMXDWDIGWP03','SIMXDWDIGWP04','SIMXDWDIGWP05','SIMXDWDIGWP07','SIMXDWDIGWP08','SIMXDWPASW001','SIMXDWPASW002','SIMXDWPASW003','SIMXDWPASW004','SIMXDWPASW005','SIMXDWPASW006','SIMXDWPASW007','SIMXDWPASW008','SIMXDWPASW009','SIMXDWPASW010','SIMXDWPASW011','SIMXDWPASW012','SIMXDWPASW013','SIMXDWPASW014','SIMXDWPASW015','SIMXDWPASW016','SIMXDWPASW017','SIMXDWPASW018','SIMXDWPASW019','SIMXDWPASW020','SIMXDWPASW021','SIMXDWPASW022','SIMXDWPASW023','SIMXDWPASW024','SIMXDWPASW025','SIMXDWPASW026','SIMXDWPASW027','SIMXDWPASW028','SIMXDWPASW029','SIMXDWPASW030','SIMXDWPASW031','SIMXDWPASW032','SIMXDWPASW033','SIMXDWPASW034','SIMXDWPASW035','SIMXDWPASW036','SIMXDWPASW037','SIMXDWPASW038','SIMXDWPASW039','SIMXDWPASW040','SIMXDWPASW041','SIMXDWPASW042','SIMXDWPASW043','SIMXDWPASW044','SIMXDWPASW045','SIMXDWPASW046','SIMXDWPASW047','SIMXDWPASW048','SIMXDWPASW049','SIMXDWPASW050','SIMXDWPASW051','SIMXDWPASW052','SIMXDWPASW053','SIMXDWPASW054','SIMXDWPASW055','SIMXDWPASW056','SIMXDWPASW057','SIMXDWPASW058','SIMXDWPASW059','SIMXDWPASW060','SIMXDWPASW061','SIMXDWPASW062','SIMXDWPASW063','SIMXDWPASW064','SIMXDWPASW065','SIMXDWPASW066','SIMXDWPASW067','SIMXDWPASW068','SIMXDWPASW069','SIMXDWPASW070','SIMXDWPASW071','SIMXDWPASW072','SIMXDWPASW073','SIMXDWPASW074','SIMXDWPASW075','SIMXDWPASW076','SIMXDWPASW077','SIMXDWPASW078','SIMXDWPASW079','SIMXDWPASW080','SIMXDWPASW081','SIMXDWPASW082','SIMXDWPASW083','SIMXDWPASW084','SIMXDWPASW085','SIMXDWPASW086','SIMXDWPASW087','SIMXDWPASW088','SIMXDWPASW089','SIMXDWPASW090','SIMXDWPASW094','SIMXDWPASW096','SIMXDWPASW097','SIMXDWPASW100','SIMXDWPASW102','SIMXDWPASW103','SIMXDWPASW107','SIMXDWPASW108','SIMXDWPASW110','SIMXDWPASW111','SIMXDWPASW112','SIMXDWPASW113','SIMXDWPASW114','SIMXDWPASW115','SIMXDWPASW116','SIMXDWPASW117','SIMXDWPASW118','SIMXDWPASW119','SIMXDWPASW121','SIMXDWPASW123','SIMXDWPASW125','SIMXDWPASW127','SIMXDWPASW128','SIMXDWPASW130','SIMXDWPASW131','SIMXDWPASW133','SIMXDWPASW135','SIMXDWPASW137','SIMXDWPASW138','SIMXDWPASW141','SIMXDWPASW144','SIMXDWPASW145','SIMXDWPASW146','SIMXDWPASW150','SIMXDWPASW151','SIMXDWPASW152','SIMXDWPASW155','SIMXDWPASW157','SIMXDWPASW159','SIMXDWPASW160','SIMXDWPASW161','SIMXDWPASW162','SIMXDWPASW165','SIMXDWPASW167','SIMXDWWKFT0003','SIMXDWWKFT0005','SIMXDWWKFT0011','SIMXDWWKFT0012','SIMXDWWKFT0015','SIMXDWWKFT0016','SIMXDWWKFT0018')
Repair-CmnClientCert -computers $computers -Verbose