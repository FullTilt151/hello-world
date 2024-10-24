--CM--
SELECT a.publisher0, 
       a.version0, 
       Count(*) [Count] 
FROM   v_r_system vrs 
       JOIN v_add_remove_programs a 
         ON a.resourceid = vrs.resourceid 
WHERE  COALESCE(active0, 0) = 1 
       AND COALESCE(client0, 0) = 1 
       AND COALESCE(obsolete0, 0) = 0 
       AND COALESCE(decommissioned0, 0) = 0 
       AND COALESCE(publisher0, '') = 'Adobe Systems Incorporated' 
       AND COALESCE(displayname0, '') = 'Adobe Acrobat DC Professional' 
	   AND COALESCE(Version0,'') = '15.006.30306' 
GROUP  BY a.publisher0, 
          a.version0 
ORDER  BY a.publisher0, 
          a.version0  

--CM Get WKIDs with Software in CM - AC
Select vrs.Netbios_Name0
FROM   v_r_system vrs 
       JOIN v_add_remove_programs a 
         ON a.resourceid = vrs.resourceid 
		 WHERE  COALESCE(active0, 0) = 1 
       AND COALESCE(client0, 0) = 1 
       AND COALESCE(obsolete0, 0) = 0 
       AND COALESCE(decommissioned0, 0) = 0 
       AND COALESCE(publisher0, '') = 'Adobe Systems Incorporated' 
       AND COALESCE(displayname0, '') = 'Adobe Acrobat DC Professional' 
	   AND COALESCE(Version0,'') = '15.006.30306' 
	   --to build bottom list, run 1E_ACsoftwareNumbers query.
	   AND vrs.Netbios_Name0 not in ('WKPF0ATJNU','WKR909X650','WKPBP74BC','WKR8GDT8A','WKPB5L63K','WKPC0MK1XW','WKPBXLP28','WKPC0J4T3Q','WKPC0J278E','WKR901HX83','WKR90AL846','WKPC0F10JN','SIMXDWSTDB3234','WKPC0N86YP','WKR90BWA78','WKR90FBB7B','WKR90C1HW3','WKMJ11M4C','WKMJXKATR','WKR90HLQ7F','WKMJ02BJ38','WKPC0NFN3R','WKR8MZ67T','WKMJ007HEF','WKMJCDPAW','WKPC0Q7KF3','WKPC0G7ZS9','WKR8CF9WA','SIMXDWDEVC3528','WKPF091E1K','WKPC0PBX9Q','WKPF0ATPE0','WKPC0MK29R','WKPB9T35R','WKR90BCE8G','WKPF0AQBWQ','WKPC0KUM0S','WKMJ05PXTB','WKPC0H9K2R','WKR90BFHD3','WKPC0Q7KG7','WKMJ0596YC','WKPF0C213H','WKR90FBBAJ','WKPC0FHDTY','WKPF0EHAUZ','WKPC0E648W','WKPC0G3PKN','WKR90B8B5P','WKPC0LASST','WKPC0N86ZA','WKPC0GGKQB','WKR90FBC1W','WKPC0K0WNZ','WKPC0FYP1E','LOUXDWDEVC2843','WKPC0JYTDV','WKR90BDWAC','WKPC0FG97P','WKMPR90BAYT2','WKMJ02GPZT','WKPB616V2','WKMJ00DEPA','WKPF0AMRPV','WKPBD271Z','WKPC0FESCC','WKMJ00DNQX','WKMJ0170S0','LOUXDWSTDB1142','WKPF0D13AQ','WKPF0D66CV','WKR902WEWY','WKPF0E2W5Q','WKMJ032SWB','WKPC0JYT0U','WKPF0C21TC','WKR90HT1BC','WKPB11Z8M','WKR901GB4A','WKR90A2L5Y','WKR90B0XED','WKMJ04KLN6','WKPC0J4SYB','WKR903093Z','WKMJ49XC8','WKMJ0508RU','WKPC0G7ZZC','WKPF0K2XZ5','WKR90L888A','WKPC0F0Z8Z','WKPF0AP2MN','WKPF0DY3E3','WKPF0D68L4','WKPC0HPU2S','WKPF0DD304','WKPB6KGG4','WKMJ057P32','WKR90NSTW8','WKPF0DSUL0','WKPC0MK2DY','WKPC0J2937','WKPC0MWB1R','WKPF095NJE','WKR900G7XM','WKMJ0649L0','WKPF0DFYZF','WKPC0DSF63','WKMJVKTAF','WKPF092JWZ','WKR900MGRW','WKPC0G7ZZ8','WKPF0DVJ6P','WKMPMP114W2Q','SIMXDWSTDB8003','WKPC0JZG9Q','WKPC0N870X','WKMJ05SAC3','WKMJ0545WB','WKPF0K0QK9','WKMJMCHMM','WKPC0FXGQM','WKPC0Q7KG4','WKPF0F0ZBH','WKPC0NFN4C','WKPF0AQA75','WKPF0AZC3Q','WKR90BA57P','WKPBY06NE','WKPB0TEXP','WKPF0DY1DH','WKPB52T2L','WKPF0AMRPN','WKPF0D68HU','WKPF0A9YFW','WKMJ00VCVN','WKR90A1FDP','WKPC0MTJQY','WKR8GCV7Z','WKPC0J4T4D','WKPC0G265H','WKPC0DSESQ','WKPC0LASTG','WKPF0AMPQD','WKPC0G4XP5','WKPC0MWBK0','WKPC0JYTEJ','WKPB0TEWN','WKPB72RG2','WKPF0H03UE','WKMP04V2V1','WKMJ05Y2QK','WKPF0D66FU','WKPC0F0DXL','WKPC0G3P42','WKR903090H','WKR9025K3Y','WKPF0DYXJV','WKPF0HXD3Q','WKMJMCHLE','SIMXDWSTDB8043','WKPF0HXAYR','WKPB965HM','WKPB9E80P','WKPF0E11GJ','WKR90NSTW6','WKPC0R2SLS','WKPC0G3Q63','WKPC0F2MK3','WKMJ05JWKD','WKMJ0545XJ','SIMXDWDEVB3485','WKR90AMT4L','WKMJ01MLC9','WKR90L888C','WKR90NZU9Z','WKR903CECX','WKPC0DW656','WKPC0E2983','WKR90F4MJ2','WKPF0E2Y85','WKMJ05J43V','WKPC0J4RWU','WKPC0MK2D6','WKPBY06PP','WKR8GEC5B','WKMJ0545CY','WKPBD292M','WKPBP649W','WKPC0E649S','WKMJ05G9BX','WKPF09SM4R','WKMP42ZTM','WKPC0MK279','WKPF0AUR1F','WKPF0AQA0Y','WKPC0N86X3','WKPC0NCGRB','WKR900E7P9','WKPC0FXH94','WKMJ009P8P','WKMJ057P0Q','WKPF09BB54','WKPF06KA1X','WKPC0MK21U','WKPF0BBEMZ','WKPBG0DYD','WKPC0F0ZSC','WKMJ04LXHL','WKPC0DSESS','WKPC0J4T72','WKPB613L7','WKR90BDWA4','WKR903CCT2','WKR90BCB3E','WKPF0EA9LM','WKR90B8B4Y','WKR90FB6P7','WKPF0AASV6','WKPB2TF5G','WKPC0J4T06','WKMPMP3Y1EC','WKPC0MS6EY','WKPC0MK2BY','WKPF0DVJ51','WKPF092JEV','WKPF0I3BE0','WKPC0JYQB5','WKPC0GBTFQ','WKPC0F0ZF0','WKR90BPNEM','WKPF0DZKES','LOUXDWDEVC2844','WKR90FBB96','WKMJ037PCJ','WKMJFWRLG','SIMXDWSTDB8012','WKPC0MK29W','WKPC0J2B9T','WKR900BY1Z','WKMJ03CTXR','WKPC0HPTG8','WKPC0DWRDP','WKPC0FGFZD','WKR9023NXM','WKMJXLAHW','WKR90BDWAF','WKPC0MWB9X','WKR909X66K','WKPC0J270D','WKPF0AMQ84','WKR90BAYPP','WKPBC98YT','WKPC0FXGR5','WKPC0J25DT','WKPC0R2RC8','KMGPB76R9Y','WKPF08MWUY','WKR902NNGA','WKPC0E649M','WKPF094KTX','WKPB719DD','WKR90BA55R','WKMJ02W2V0','WKMJ05SSNL','WKMJ39P7V','WKPC0PBXAP','LOUXDWDEVB1725','WKMJ03DJTE','WKPBD12EC','WKMJ01MGX','WKPC0J28SP','WKMJ0545WC','WKPB970KN','WKMP47G12','WKPF0F4QWS','WKPB6KAD3','WKPC0GJ63L','WKPC0G4Y8D','WKPF0C76T7','WKR90BWAHZ','WKPF094KM5','WKPF0D90TF','WKPF0E11HL','WKMJ031WE8','WKPC0JYTET','WKPF09SM69','WKR9016EK0','WKPC0E63PS','WKR90FBBY7','WKPC0MK20K','WKPF0K0PQ3','WKPC0LASU3','WKPBF1L55','WKPC0F0ZPM','WKPC0G7ZZZ','WKMJ32V24','WKPF0I3EXP','WKMJ031WDP','WKR90BWA6K','WKR903094R','WKMJ03DJTH','WKPC0Q7KGT','WKR90A2L78','WKPC0MK223','WKMJ02W2VL','WKMJ051PRL','WKR90FB6NX','WKPB965KP','WKPF0D8WUQ','WKR90FBBAK')
