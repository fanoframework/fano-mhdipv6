(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
program app;

uses

    {$IFDEF UNIX}
    cthreads,
    {$ENDIF}
    sysutils,
    fano,
    bootstrap;

var
    appInstance : IWebApplication;
    cliParams : ICliParams;
    svrConfig : TMhdSvrConfig;

begin
    cliParams := (TGetOptsParams.create() as ICliParamsFactory)
        .addOption('host', 1)
        .addOption('port', 1)
        .build();
    svrConfig.host := cliParams.getOption('host', '127.0.0.1');
    svrConfig.port := cliParams.getOption('port', 20477);
    writeln('Starting application at ', svrConfig.host, ':', svrConfig.port);

    svrConfig.documentRoot := getCurrentDir() + '/public';
    svrConfig.serverName := 'http.fano';
    svrConfig.serverAdmin := 'admin@http.fano';
    svrConfig.serverSoftware := 'Fano Framework Web App';
    svrConfig.timeout := 120;

    //uncomment following lines support https
    //svrConfig.useTLS := true;
    //svrConfig.tlsKey := '/path/to/ssl/cert/key';
    //svrConfig.tlsCert := '/path/to/ssl/cert/cert';

    (*!-----------------------------------------------
     * Bootstrap libmicrohttpd application
     *
     * @author AUTHOR_NAME <author@email.tld>
     *------------------------------------------------*)
    appInstance := TDaemonWebApplication.create(
        TMhdAppServiceProvider.create(
            TAppServiceProvider.create(),
            svrConfig
        ),
        TAppRoutes.create()
    );
    appInstance.run();
end.