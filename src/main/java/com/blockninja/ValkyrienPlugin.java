package com.blockninja;

import com.blockninja.util.JavaTemplateParser;
import freemarker.template.Template;
import net.mcreator.generator.Generator;
import net.mcreator.generator.GeneratorFlavor;
import net.mcreator.generator.template.InlineTemplatesHandler;
import net.mcreator.java.CodeCleanup;
import net.mcreator.plugin.JavaPlugin;
import net.mcreator.plugin.MCREventListener;
import net.mcreator.plugin.Plugin;
import net.mcreator.plugin.PluginLoader;
import net.mcreator.plugin.events.PreGeneratorsLoadingEvent;
import net.mcreator.plugin.events.WorkspaceBuildStartedEvent;
import net.mcreator.plugin.events.workspace.MCreatorLoadedEvent;
import net.mcreator.io.FileIO;
import net.mcreator.plugin.events.workspace.WorkspaceRefactoringEvent;
import net.mcreator.plugin.events.workspace.WorkspaceSavedEvent;
import net.mcreator.ui.MCreator;
import net.mcreator.ui.action.ActionRegistry;
import net.mcreator.workspace.Workspace;
import net.mcreator.workspace.WorkspaceFileManager;
import net.mcreator.workspace.settings.WorkspaceSettings;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.io.File;
import java.io.InputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

public class ValkyrienPlugin extends JavaPlugin {
    public static final String LOG_NAME = "Valkyrien";
    private static final Logger LOG = LogManager.getLogger(LOG_NAME);

    public ValkyrienPlugin(Plugin plugin) {
        super(plugin);

        this.addListener(MCreatorLoadedEvent.class, new MCREventListener<MCreatorLoadedEvent>() {
            @Override
            public void eventTriggered(MCreatorLoadedEvent mCreatorLoadedEvent) {
                onLoad(mCreatorLoadedEvent.getMCreator());
            }
        });
    }


    public void onLoad(MCreator mcreator) {
        Generator currentGenerator = mcreator.getGenerator();

        if (currentGenerator != null && currentGenerator.getGeneratorConfiguration().getGeneratorFlavor() == GeneratorFlavor.FORGE) {
            WorkspaceSettings workspaceSettings = mcreator.getWorkspaceSettings();
            String modid = workspaceSettings.getModID();
            String modname = workspaceSettings.getJavaModName();

            if (modid.isEmpty() || modname.isEmpty()) {
                return;
            }



            String codeFolder = "src/main/java/" + workspaceSettings.getModElementsPackage().replace(".", "/") + "/ships/";

            //TODO: get all files in DIR
            List<String> templates = List.of("ForceData", "ForceDirectionMode", "ForceInducedShips", "ForceMode", "OnShipLoad", "RotData", "TeleportHandler");

            for (String template : templates) {
                File javaFile = new File(mcreator.getWorkspaceFolder(), codeFolder + template + ".java");
                if (!javaFile.exists()) {
                    try {
                        String formattedCode = JavaTemplateParser.fullyParseTemplate(mcreator, template);
                        FileIO.writeStringToFile(formattedCode, javaFile);

                        LOG.info(template+".java generated successfully at: " + javaFile.getPath());
                    } catch (Exception e) {
                        LOG.error("Error generating "+template+".java!", e);
                    }
                }
            }

            File javaFile = new File(mcreator.getWorkspaceFolder(), "src/main/java/" + workspaceSettings.getModElementsPackage().replace(".", "/") + "/mixins/" + "ServerShipObjectWorldAccessor.java");
            if (!javaFile.exists()) {
                try {
                    String formattedCode = JavaTemplateParser.fullyParseTemplate(mcreator, "ServerShipObjectWorldAccessor");
                    FileIO.writeStringToFile(formattedCode, javaFile);

                    LOG.info("ServerShipObjectWorldAccessor.java generated successfully at: " + javaFile.getPath());
                } catch (Exception e) {
                    LOG.error("Error generating ServerShipObjectWorldAccessor.java!", e);
                }
            }
        }
    }
}
